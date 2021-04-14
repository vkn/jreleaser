/*
 * SPDX-License-Identifier: Apache-2.0
 *
 * Copyright 2020-2021 Andres Almiray.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jreleaser.model;

import org.jreleaser.util.JReleaserLogger;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import static org.jreleaser.util.StringUtils.isNotBlank;

/**
 * @author Andres Almiray
 * @since 0.1.0
 */
public class JReleaserContext {
    private final JReleaserLogger logger;
    private final JReleaserModel model;
    private final Path basedir;
    private final Path outputDirectory;
    private final boolean dryrun;
    private final List<String> errors = new ArrayList<>();

    private String distributionName;
    private String toolName;
    private String announcerName;
    private String changelog;

    public JReleaserContext(JReleaserLogger logger,
                            JReleaserModel model,
                            Path basedir,
                            Path outputDirectory,
                            boolean dryrun) {
        this.logger = logger;
        this.model = model;
        this.basedir = basedir;
        this.outputDirectory = outputDirectory;
        this.dryrun = dryrun;
    }

    public List<String> validateModel() {
        if (!errors.isEmpty()) return errors;

        this.model.getEnvironment().initProps(this);

        logger.info("Validating configuration");

        try {
            JReleaserModelValidator.validate(this, errors);
        } catch (Exception e) {
            logger.trace(e);
            errors.add(e.toString());
        }

        if (!errors.isEmpty()) {
            logger.error("== JReleaser ==");
            errors.forEach(logger::error);
        }

        return errors;
    }

    public JReleaserLogger getLogger() {
        return logger;
    }

    public JReleaserModel getModel() {
        return model;
    }

    public Path getBasedir() {
        return basedir;
    }

    public Path getOutputDirectory() {
        return outputDirectory;
    }

    public Path getChecksumsDirectory() {
        return outputDirectory.resolve("checksums");
    }

    public Path getSignaturesDirectory() {
        return outputDirectory.resolve("signatures");
    }

    public boolean isDryrun() {
        return dryrun;
    }

    public String getChangelog() {
        return changelog;
    }

    public void setChangelog(String changelog) {
        this.changelog = changelog;
    }

    public boolean hasDistributionName() {
        return isNotBlank(distributionName);
    }

    public boolean hasToolName() {
        return isNotBlank(toolName);
    }

    public boolean hasAnnouncerName() {
        return isNotBlank(announcerName);
    }

    public String getDistributionName() {
        return distributionName;
    }

    public void setDistributionName(String distributionName) {
        this.distributionName = distributionName;
    }

    public String getToolName() {
        return toolName;
    }

    public void setToolName(String toolName) {
        this.toolName = toolName;
    }

    public String getAnnouncerName() {
        return announcerName;
    }

    public void setAnnouncerName(String announcerName) {
        this.announcerName = announcerName;
    }

    @Override
    public String toString() {
        return "JReleaserContext[" +
            "basedir=" + basedir.toAbsolutePath() +
            ", outputDirectory=" + outputDirectory.toAbsolutePath() +
            ", dryrun=" + dryrun +
            "]";
    }
}
