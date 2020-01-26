Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC87149AE7
	for <lists+linux-spi@lfdr.de>; Sun, 26 Jan 2020 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAZOJc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jan 2020 09:09:32 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43333 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAZOJc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Jan 2020 09:09:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id v126so3469747ywc.10;
        Sun, 26 Jan 2020 06:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIBXGruVtXLWGDKFA1TCcvHJQqqB8GBIh9kNTOb/fuk=;
        b=Mk4oCwNGg6HxZOtQSZFkfJHL9c2GyiV2XZSrCjIZLjVPjFswi+0SA3YyY735R1464d
         GdbjNQpbIy74Y7/IXA+Zxf1q761kzZujmIa9tQOA9zWjNBXcXlp4aoTi2RjczfRToK7j
         g7xN+PI9jYpjf27CWaDNgToDXfzJ0/fTnu0wC8ZjWfvaX5pl6isPQ+xlQz18JttWgltn
         15X8obeoJYk10blNGh+jlccabPGO06rOfqIXQdieCaOmLN3RfczNKpsSYOE2S+Q0oopx
         Hi/OOdbuNjJCajIGkP9AF1xHcjRZ2yB8MrN/WWwDf+7q3pTM54XQf89HTIufhSiYPRkU
         o4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIBXGruVtXLWGDKFA1TCcvHJQqqB8GBIh9kNTOb/fuk=;
        b=PcqR3A+wfO3lYb/pN15qqYHTBEJTLBL77Tm50YFhLUp4LdUS41UJJHame7JVN7oiNQ
         wZ49DgvCmejQcQky9WYgNP0H9hRkifZvUNah9CZGOPVCVeh+FrC3Z6Km1paN6IQ96lOZ
         kiwnomg+MVUOcWs8hRfdCNL1OZa/q+c9HO7UCBJElMmKTcWnjipUcfawU6Lw+tb8L0a2
         vQxTcwxc+4nHVNVoOcOZgFnLBUoAZAxq6mh8FFRNb+CXFvu9We4+ayN8Qemzm/Vx4/0m
         53citMoSo+1bl4HYz+7mxNG83NSrxyCBsDzl2Y6nubGPfUeSiwqOt3fZUg1BJ5Er7Erd
         HmTw==
X-Gm-Message-State: APjAAAVYlimlLmZWf6++sOjE01Ut9DGhxtk+K4XVums5RLQLWHjtwHMO
        gTeW4GoXq4TH7vjuLurIfbfmpfI4JkY=
X-Google-Smtp-Source: APXvYqzDzxEFyqha9UjT6YyU/ysiOH2LW1TWq1QPbgfRd5yEbDaYb4T5n+BpcGks0XD8Em3+6O8+YQ==
X-Received: by 2002:a0d:ccd2:: with SMTP id o201mr8773523ywd.492.1580047770669;
        Sun, 26 Jan 2020 06:09:30 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id a12sm5237214ywa.95.2020.01.26.06.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 06:09:30 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] spi: fspi: enable fspi on imx8qxp and imx8mm
Date:   Sun, 26 Jan 2020 08:09:08 -0600
Message-Id: <20200126140913.2139260-1-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Pull in this patch from NXP's upstream repo to
enable fspi on imx8qxp and imx8mm

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 8c5084a3a617..00c7899428a1 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -324,6 +324,22 @@ static const struct nxp_fspi_devtype_data lx2160a_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8mm_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = true,  /* little-endian    */
+};
+
+static const struct nxp_fspi_devtype_data imx8qxp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1076,6 +1092,8 @@ static int nxp_fspi_resume(struct device *dev)
 
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
+	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
+	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.24.0

