Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B790614B064
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2020 08:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgA1H0U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jan 2020 02:26:20 -0500
Received: from fallback24.m.smailru.net ([94.100.187.223]:51274 "EHLO
        fallback24.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725776AbgA1H0T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jan 2020 02:26:19 -0500
X-Greylist: delayed 2426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 02:26:16 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=bTnKbozzhWeZGDSGPXNp6iiMNAQE8y4xzMdDHG/r5pA=;
        b=ZhkJ0hf4hbi37/FYt4V3VOjRDrOG9AypdI/anBh8KooIyyjJWGyPtilk3q8qm3hI/+5cE2tfks86oK0y4NFT7UXmVi9uUKjQkfX7+3ELDxpPH/nsQ4qBkvzZm/KK3A7KPLDiD7AhUgI+jxtb8UpS3u+cJD1gCZbOP9DywM5deWc=;
Received: from [10.161.64.58] (port=36020 helo=smtp50.i.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1iwKdA-00033U-8m; Tue, 28 Jan 2020 09:45:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=bTnKbozzhWeZGDSGPXNp6iiMNAQE8y4xzMdDHG/r5pA=;
        b=ZhkJ0hf4hbi37/FYt4V3VOjRDrOG9AypdI/anBh8KooIyyjJWGyPtilk3q8qm3hI/+5cE2tfks86oK0y4NFT7UXmVi9uUKjQkfX7+3ELDxpPH/nsQ4qBkvzZm/KK3A7KPLDiD7AhUgI+jxtb8UpS3u+cJD1gCZbOP9DywM5deWc=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1iwKd7-0006BQ-9o; Tue, 28 Jan 2020 09:45:45 +0300
To:     linux-spi@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
From:   Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
Message-ID: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
Date:   Tue, 28 Jan 2020 09:48:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 0A44E481635329DB0E1AA8A03B392317F65658A2B47C0803D86CC449A42D0EB765E403FAF569B5D6F688BCB05C26794D0C8ED34BB3F46387ACEB3F4835A4B7F2BCF099B57AA8BE3EC186D49F45BF5FC6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78CB87876C5D626D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063794187E5B4E0D50D78638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCA7AB8D5C6E4DD08F041628B6F84CC414DA84470D9C554E32389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947CCE135D2742255B356136E347CC761E074AD6D5ED66289B52E1A3F18E62937ED6A8C29749A63C2581725E5C173C3A84C37D867A29DFE2655CBA3038C0950A5D36B5C8C57E37DE458B5A02E28F51ECAD4422CA9DD8327EE4930A3850AC1BE2E735E176AB8373D62B2A36D7A40984D72E1A731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB2476CD8FF3B992A86DA6B86BF0F04C3FD7D53C8DA9176C40ABEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: OK
X-7564579A: EEAE043A70213CC8
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC8C5F7A7658E73248752EF3CFDAF6BA267DB144210A9428833FE4EE245425D0B5
X-7FA49CB5: 0D63561A33F958A536949672F6CE9685CE4EFE95F4C5E8CCF7BFE683CC1B2A8D8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22491819D55BF2DA05E976E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8B86F44BBDAD779E023AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90054F94DD2E9EA85DB6612C9F25DD2C55BC752EF3CFDAF6BA26B28945B2A1A9FE06C099ADC76E806A99D50E20E2BC48EF5A30D242760C51EA9CEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Subject: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support

eSPI controller can't send transactions without hardware chip selects.
So, to use GPIO chip selects with eSPI controller we need to use one 
dedicated hardware chip select signal. To specify shared chip select for 
GPIO use "fsl,espi-shared-chipselect" DT property.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
  .../devicetree/bindings/spi/fsl-spi.txt       |  2 +
  drivers/spi/spi-fsl-espi.c                    | 40 ++++++++++++++-----
  2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt 
b/Documentation/devicetree/bindings/spi/fsl-spi.txt
index 411375eac54d..cfae3e762926 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -47,6 +47,8 @@ Required properties:
  Optional properties:
  - fsl,csbef: chip select assertion time in bits before frame starts
  - fsl,csaft: chip select negation time in bits after frame ends
+- fsl,espi-shared-chipselect: hardware CS used for gpio chip selects
+- cs-gpios: GPIOs to use as chip selects, see spi-controller.yaml

  Example:
  	spi@110000 {
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f20326714b9d..edffaa5333b0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -107,6 +107,7 @@ struct fsl_espi {
  	u32 spibrg;             /* SPIBRG input clock */

  	struct completion done;
+	int shared_cs;
  };

  struct fsl_espi_cs {
@@ -328,6 +329,7 @@ static void fsl_espi_setup_transfer(struct 
spi_device *spi,
  	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
  	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
  	u32 hw_mode_old = cs->hw_mode;
+	int chip_select = spi->cs_gpiod ? espi->shared_cs : spi->chip_select;

  	/* mask out bits we are going to set */
  	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16 | CSMODE_PM(0xF));
@@ -345,7 +347,7 @@ static void fsl_espi_setup_transfer(struct 
spi_device *spi,

  	/* don't write the mode register if the mode doesn't change */
  	if (cs->hw_mode != hw_mode_old)
-		fsl_espi_write_reg(espi, ESPI_SPMODEx(spi->chip_select),
+		fsl_espi_write_reg(espi, ESPI_SPMODEx(chip_select),
  				   cs->hw_mode);
  }

@@ -359,7 +361,12 @@ static int fsl_espi_bufs(struct spi_device *spi, 
struct spi_transfer *t)
  	reinit_completion(&espi->done);

  	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	spcom = SPCOM_CS(spi->chip_select);
+	if (spi->cs_gpiod) {
+		gpiod_set_value(spi->cs_gpiod, 1);
+		spcom = SPCOM_CS(espi->shared_cs);
+	} else {
+		spcom = SPCOM_CS(spi->chip_select);
+	}
  	spcom |= SPCOM_TRANLEN(t->len - 1);

  	/* configure RXSKIP mode */
@@ -385,12 +392,16 @@ static int fsl_espi_bufs(struct spi_device *spi, 
struct spi_transfer *t)

  	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
  	ret = wait_for_completion_timeout(&espi->done, 2 * HZ);
+
+	if (spi->cs_gpiod) {
+		gpiod_set_value(spi->cs_gpiod, 0);
+	}
+
  	if (ret == 0)
  		dev_err(espi->dev, "Transfer timed out!\n");

  	/* disable rx ints */
  	fsl_espi_write_reg(espi, ESPI_SPIM, 0);
-
  	return ret == 0 ? -ETIMEDOUT : 0;
  }

@@ -475,9 +486,10 @@ static int fsl_espi_do_one_msg(struct spi_master 
*master,

  static int fsl_espi_setup(struct spi_device *spi)
  {
-	struct fsl_espi *espi;
  	u32 loop_mode;
+	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
  	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
+	int chip_select = spi->cs_gpiod ? espi->shared_cs : spi->chip_select;

  	if (!cs) {
  		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
@@ -486,11 +498,10 @@ static int fsl_espi_setup(struct spi_device *spi)
  		spi_set_ctldata(spi, cs);
  	}

-	espi = spi_master_get_devdata(spi->master);

  	pm_runtime_get_sync(espi->dev);

-	cs->hw_mode = fsl_espi_read_reg(espi, ESPI_SPMODEx(spi->chip_select));
+	cs->hw_mode = fsl_espi_read_reg(espi, ESPI_SPMODEx(chip_select));
  	/* mask out bits we are going to set */
  	cs->hw_mode &= ~(CSMODE_CP_BEGIN_EDGECLK | CSMODE_CI_INACTIVEHIGH
  			 | CSMODE_REV);
@@ -659,7 +670,7 @@ static void fsl_espi_init_regs(struct device *dev, 
bool initial)
  }

  static int fsl_espi_probe(struct device *dev, struct resource *mem,
-			  unsigned int irq, unsigned int num_cs)
+			  unsigned int irq, unsigned int num_cs, int shared_cs)
  {
  	struct spi_master *master;
  	struct fsl_espi *espi;
@@ -687,6 +698,10 @@ static int fsl_espi_probe(struct device *dev, 
struct resource *mem,

  	espi->dev = dev;
  	espi->spibrg = fsl_get_sys_freq();
+	espi->shared_cs = shared_cs;
+	if (shared_cs >= 0) {
+		master->use_gpio_descriptors = true;
+	}
  	if (espi->spibrg == -1) {
  		dev_err(dev, "Can't get sys frequency!\n");
  		ret = -EINVAL;
@@ -757,7 +772,7 @@ static int of_fsl_espi_probe(struct platform_device 
*ofdev)
  	struct device *dev = &ofdev->dev;
  	struct device_node *np = ofdev->dev.of_node;
  	struct resource mem;
-	unsigned int irq, num_cs;
+	unsigned int irq, num_cs, shared_cs;
  	int ret;

  	if (of_property_read_bool(np, "mode")) {
@@ -777,7 +792,14 @@ static int of_fsl_espi_probe(struct platform_device 
*ofdev)
  	if (!irq)
  		return -EINVAL;

-	return fsl_espi_probe(dev, &mem, irq, num_cs);
+	ret = of_property_read_u32(np, "fsl,espi-shared-chipselect", &shared_cs);
+	if (!ret) {
+		dev_info(dev, "Using CS%d as shared for GPIO CS\n", shared_cs);
+	} else {
+		shared_cs = -1;
+	}
+
+	return fsl_espi_probe(dev, &mem, irq, num_cs, shared_cs);
  }

  static int of_fsl_espi_remove(struct platform_device *dev)
-- 
2.24.0
