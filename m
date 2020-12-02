Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0A2CBF84
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgLBOZv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 09:25:51 -0500
Received: from smtp52.i.mail.ru ([94.100.177.112]:39296 "EHLO smtp52.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLBOZv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 09:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=mOHwP8mDEN496y+qMdN1CmEAokVfvM967Hi3u6YkgA0=;
        b=SAsnCC4fhfMrOF0FsN6pHneAyahSwobUS2qvBRls/7t4++nqHAC1NVa7WtjZ4YmCYgHgtB8cFnWv9y8f+17XwW9LVPrmzxeSwSBwql2YV8rg40HhTVmvcDuMydnk6oizuG6HzG45xEHdf/5OcOEwucoXq1rmStTq1R0Dt/beBmU=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1kkT43-0001UE-Ix; Wed, 02 Dec 2020 17:25:03 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
Cc:     olteanv@gmail.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR
Date:   Wed,  2 Dec 2020 17:25:52 +0300
Message-Id: <20201202142552.44385-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD913934B9F4F7782282FAC7817DA5BAB1510E3E06D68F406FB00894C459B0CD1B94135E7C8DC773407338B72EEF72813FA0CAA99D27256FE1F7B9585C59A2DDEF7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7444CB0504BAF4550EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F757A79C3007ACA28638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC2F4B0AD4E52E613AFDB4DA317105496552BA022FB23D4558389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C362968DCAA3E4B45B117882F4460429728AD0CFFFB425014E1D3B0F1236BFD7A076E601842F6C81A19E625A9149C048EE7532CA1512B81981E45489B29CB19804D8FC6C240DEA76429449624AB7ADAF37B2D370F7B14D4BC40A6AB1C7CE11FEE310D407B19AF7F7506136E347CC761E07C4224003CC8364768BB5CB66B4D4C327A7F4EDE966BC389F9E8FC8737B5C22490DA844A29351D9B7089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C455ECF6163D76FB543847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-B7AD71C0: 6FEFE4C63DFE2D85469AD6E133326EAB664F5199923B286EEC27507A4F178EF731D5F97383FCDD8DDAB35C93FB886A97
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C28BBABB5229571E6F7D7F8DFADC3338663FA82582179B0419C2B6934AE262D3EE7EAB7254005DCED1C8AEA1E975C27AC1E0A4E2319210D9B64D260DF9561598F01A9E91200F654B017A45118377F5F9E8E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC4AAAB09126F554BCC1203D900E3B9BFE5F6BD6B20393DB687425501881F70B89E1A6A330446DF24770229699A8CD24C53
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj8a0f6CGnvE47zToP3B/+yg==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB243CF3E237C2B27781D527EF3858F4C6C42A405623B4F16E0BEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If cs-gpios property is used in devicetree then ctlr->num_chipselect value
may be changed by spi_get_gpio_descs().
So use ctlr->max_native_cs instead of ctlr->num_chipselect to set SPI_MCR

Fixes: 4fcc7c2292de (spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR)
Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1a08c1d584ab..028736687488 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1165,7 +1165,7 @@ static int dspi_init(struct fsl_dspi *dspi)
 	unsigned int mcr;
 
 	/* Set idle states for all chip select signals to high */
-	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->num_chipselect - 1, 0));
+	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->max_native_cs - 1, 0));
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		mcr |= SPI_MCR_XSPI;
@@ -1250,7 +1250,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
-		ctlr->num_chipselect = pdata->cs_num;
+		ctlr->num_chipselect = ctlr->max_native_cs = pdata->cs_num;
 		ctlr->bus_num = pdata->bus_num;
 
 		/* Only Coldfire uses platform data */
@@ -1263,7 +1263,7 @@ static int dspi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "can't get spi-num-chipselects\n");
 			goto out_ctlr_put;
 		}
-		ctlr->num_chipselect = cs_num;
+		ctlr->num_chipselect = ctlr->max_native_cs = cs_num;
 
 		of_property_read_u32(np, "bus-num", &bus_num);
 		ctlr->bus_num = bus_num;
-- 
2.29.2

