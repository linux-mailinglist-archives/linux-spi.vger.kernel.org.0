Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4001FA7CD
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 06:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFPEhX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 00:37:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47878 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgFPEhX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 00:37:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 48B922004C6;
        Tue, 16 Jun 2020 06:37:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E09A2003FE;
        Tue, 16 Jun 2020 06:37:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 04091402CF;
        Tue, 16 Jun 2020 12:37:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        marex@denx.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 0/3] Convert mxs/imx spi/cspi/lpspi binding to json-schema
Date:   Tue, 16 Jun 2020 12:26:12 +0800
Message-Id: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series converts mxs/imx spi/cspi/lpspi binding to json-schema.

In fsl-imx-cspi.yaml, also update compatible, remove obsolete properties
"fsl,spi-num-chipselects" and update the example based on latest DT file;

In spi-fsl-lpspi.yaml, the original maintainer's email address pandy.gao@nxp.com
is no longer valid, so I use mine.

Compared to V2, this patch series mainly removes redundant 'maxItems' in 'clocks'
and 'clock-names' property, also drop "clock-frequency" property's type.

Anson Huang (3):
  dt-bindings: spi: Convert mxs spi to json-schema
  dt-bindings: spi: Convert imx cspi to json-schema
  dt-bindings: spi: Convert imx lpspi to json-schema

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       | 56 -------------
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml      | 97 ++++++++++++++++++++++
 Documentation/devicetree/bindings/spi/mxs-spi.txt  | 26 ------
 Documentation/devicetree/bindings/spi/mxs-spi.yaml | 56 +++++++++++++
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      | 29 -------
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     | 60 +++++++++++++
 6 files changed, 213 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml

-- 
2.7.4

