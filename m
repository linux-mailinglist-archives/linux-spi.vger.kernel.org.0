Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F1135D38
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2020 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgAIPyF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jan 2020 10:54:05 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732573AbgAIPyE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jan 2020 10:54:04 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EAEA9FEA2FA6E372B4D1;
        Thu,  9 Jan 2020 15:54:02 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Jan 2020 15:54:02 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jan 2020
 15:54:02 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
Message-ID: <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
Date:   Thu, 9 Jan 2020 15:54:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1575900490-74467-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/12/2019 14:08, John Garry wrote:
> +	if (ret)
> +		return ret;
> +
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, len);
> +
> +	return 0;
> +}
> +
> +static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct hisi_sfc_v3xx_host *host;
> +	struct spi_device *spi = mem->spi;
> +	u8 chip_select = spi->chip_select;
> +
> +	host = spi_controller_get_devdata(spi->master);
> +
> +	return hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
> +}
> +
> +static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
> +	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
> +	.exec_op = hisi_sfc_v3xx_exec_op,
> +};
> +
> +static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hisi_sfc_v3xx_host *host;
> +	struct spi_controller *ctlr;
> +	u32 version;
> +	int ret;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*host));
> +	if (!ctlr)
> +		return -ENOMEM;
> +


Hi Mark,

> +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
> +			  SPI_TX_DUAL | SPI_TX_QUAD;

I have an issue with dual/quad support. I naively thought that setting 
these bits would give me the highest protocol available.

However, now I notice that spi_device.mode needs to be set for supported 
protocols for the slave - I'm using the generic spi mem ops to check if 
protocols are supported based on this value.

 From checking acpi_spi_add_resource() or anywhere else, I cannot see 
how SPI_RX_DUAL or the others are set for spi_device.mode. What am I 
missing? Are these just not supported yet for ACPI? Or should the 
spi-nor code not be relying on this since we should be able to get this 
info from the SPI NOR part?

Cheers,
John

> +
> +	host = spi_controller_get_devdata(ctlr);
> +	host->dev = dev;
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	host->regbase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(host->regbase)) {
> +		ret = PTR_ERR(host->regbase);
> +		goto err_put_master;

