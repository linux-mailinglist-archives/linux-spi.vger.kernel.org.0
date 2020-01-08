Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DB133B10
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 06:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgAHFZ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 00:25:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34552 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHFZ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jan 2020 00:25:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0085PM7F053176;
        Tue, 7 Jan 2020 23:25:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578461122;
        bh=tkOTNhAqYE1x3Eo5rHG4Lthmtqq3DGR51ZA49CKqPEo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R5KYEY5Dwh9gDpKNAwBiJkPf2SDlHH8VPAuEUoomniZOFpwSuM2xtZMROurQNMfwY
         8tlTeUgvBbqi1aWR5NNfaBD9Arg1D2hsDUfCVEmyREE8qYe2I/FSZ0qk3EPk/9PCxz
         M5lEzFh0yKEPozQzY8g6UA3MuuAzPx+y5HR4mA0o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0085PMsu012399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 23:25:22 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 23:25:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 23:25:21 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0085PIVE114824;
        Tue, 7 Jan 2020 23:25:19 -0600
Subject: Re: [PATCH v6 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ac26ecfe-d45c-db70-df8f-91da32c9925a@ti.com>
Date:   Wed, 8 Jan 2020 10:55:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
[...]
On 30/12/19 1:11 pm, Ramuthevar,Vadivel MuruganX wrote:
> +static int cqspi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct struct_cqspi *cqspi;
> +	struct spi_master *master;
> +	struct reset_control *rstc, *rstc_ocp;
> +	const struct cqspi_driver_platdata *ddata;
> +	struct cqspi_platform_data *pdata = NULL;
> +	struct resource *res = NULL;
> +	int ret;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");
> +		return -ENOMEM;
> +	}
> +	master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL |
> +				SPI_RX_OCTAL;
> +	master->setup = cqspi_setup;
> +	master->mem_ops = &cqspi_mem_ops;
> +	master->dev.of_node = pdev->dev.of_node;
> +	cqspi = spi_master_get_devdata(master);
> +	cqspi->pdev = pdev;
> +
> +	pdata = devm_kmalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);

devm_kzalloc()?

> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	pdev->dev.platform_data = pdata;
> +
> +	/* Obtain QSPI clock. */
> +	cqspi->clk = devm_clk_get(&pdev->dev, "qspi");

clock-name of "qspi" is not mandatory as per DT binding and current DT
files don't have clock-names property. This therefore cause probe to
fail. This should remain:

	cqspi->clk = devm_clk_get(&pdev->dev, "NULL");

> +	if (IS_ERR(cqspi->clk)) {
> +		dev_err(&pdev->dev, "cannot get qspi clk\n");
> +		return PTR_ERR(cqspi->clk);
> +	}
> +	pdata->master_ref_clk_hz = clk_get_rate(cqspi->clk);
> +
> +	ret = clk_prepare_enable(cqspi->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable qspi clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Obtain configuration from OF. */
> +	ret = cqspi_of_get_pdata(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Get platform data failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	cqspi->res = res;
> +	/* Obtain and remap controller address. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(cqspi->iobase)) {
> +		dev_err(dev, "Cannot remap controller address.\n");
> +		return PTR_ERR(cqspi->iobase);
> +	}
> +
> +	/* Obtain and remap AHB address. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	cqspi->qspi_ahb_virt = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(cqspi->qspi_ahb_virt)) {
> +		dev_err(dev, "Cannot remap AHB address.\n");
> +		return PTR_ERR(cqspi->qspi_ahb_virt);
> +	}
> +	cqspi->ahbbase = res;
> +	cqspi->ahb_size = resource_size(res);
> +
> +	/* Obtain QSPI reset control */
> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
> +	if (IS_ERR(rstc)) {
> +		dev_err(dev, "Cannot get QSPI reset.\n");
> +		return PTR_ERR(rstc);
> +	}
> +
> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
> +	if (IS_ERR(rstc_ocp)) {
> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
> +		return PTR_ERR(rstc_ocp);
> +	}
> +
> +	reset_control_assert(rstc);
> +	reset_control_deassert(rstc);
> +
> +	reset_control_assert(rstc_ocp);
> +	reset_control_deassert(rstc_ocp);
> +
> +	ddata  = of_device_get_match_data(dev);
> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
> +		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
> +						   pdata->master_ref_clk_hz);
> +
> +	if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))
> +		cqspi->use_dac_mode = false;
> +
> +	init_completion(&cqspi->transfer_complete);
> +
> +	/* Obtain IRQ line. */
> +	cqspi->irq = platform_get_irq(pdev, 0);
> +	if (cqspi->irq < 0) {
> +		dev_err(dev, "platform_get_irq failed.\n");
> +		ret = -ENXIO;
> +	}
> +	ret = devm_request_irq(dev, cqspi->irq, cqspi_irq_handler, 0,
> +			       pdev->name, cqspi);
> +	if (ret) {
> +		dev_err(dev, "request_irq failed.\n");
> +		goto out_clk_disable;
> +	}
> +
> +	master->bus_num = pdata->bus_num;
> +	master->num_chipselect = pdata->num_chipselect;

Where is pdata->bus_num and pdata->num_chipselect initialized? This
causes devm_spi_register_master() to fail randomly as num_chipselect may
be 0.

> +	mutex_init(&cqspi->lock);
> +	platform_set_drvdata(pdev, master);
> +	cqspi_controller_init(cqspi);
> +	cqspi->current_cs = -1;
> +
> +	ret = devm_spi_register_master(dev, master);
> +	if (ret) {
> +		dev_err(&pdev->dev, "devm_spi_register_master failed.\n");
> +		goto err_of;
> +	}
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_disable_unprepare(cqspi->clk);
> +err_of:
> +	spi_master_put(master);
> +	dev_err(&pdev->dev, "Cadence QSPI controller probe failed\n");
> +	return ret;
> +}
> +

-- 
Regards
Vignesh
