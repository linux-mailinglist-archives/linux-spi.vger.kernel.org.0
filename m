Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D3E160E4B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBQJSQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 04:18:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:31048 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgBQJSP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 04:18:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 01:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
   d="scan'208";a="433734048"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2020 01:18:13 -0800
Received: from [10.226.38.21] (unknown [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 2F17D5804A2;
        Mon, 17 Feb 2020 01:18:10 -0800 (PST)
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214130952.GI4827@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
Date:   Mon, 17 Feb 2020 17:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200214130952.GI4827@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

    Thank you for the review comments,  response in inline.

On 14/2/2020 9:09 PM, Mark Brown wrote:
> On Fri, Feb 14, 2020 at 07:46:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>
>> +static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
>> +{
>> +	struct cqspi_st *cqspi = dev;
>> +	unsigned int irq_status;
>> +
>> +	/* Read interrupt status */
>> +	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
>> +
>> +	/* Clear interrupt */
>> +	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
>> +
>> +	irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
>> +
>> +	if (irq_status)
>> +		complete(&cqspi->transfer_complete);
>> +
>> +	return IRQ_HANDLED;
>> +}
> This will unconditionally handle the interrupt regardless of if the
> hardware was actually flagging an interrupt which will break shared
> interrupts and the fault handling code in genirq.
Yes, you're correct, it doesn't check unconditionally, will update the
INT flag in the INT_STATUS register after successful completion of 
read/write operation.
but in this case it is dedicated to qspi-interrupt,not shared with any 
other HW/SW interrupts.
>> +	tmpbufsize = op->addr.nbytes + op->dummy.nbytes;
>> +	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
>> +	if (!tmpbuf)
>> +		return -ENOMEM;
> I'm not clear where tmpbuf gets freed or passed out of this function?
Agreed!, will fix it.
>> +
>> +	if (op->addr.nbytes) {
>> +		for (i = 0; i < op->addr.nbytes; i++)
>> +			tmpbuf[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
>> +
>> +		addr_buf = tmpbuf;
> We assign tmpbuf to addr_buf here but addr_buf just gets read from so
> it's not via that AFAICT.
Agreed, will fix it.
>> +	}
>> +	/* Invalid address return zero. */
> Missing blank line.
Noted.
>> +static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>> +{
>> +	struct cqspi_st *cqspi = f_pdata->cqspi;
>> +	void __iomem *reg_base = cqspi->iobase;
>> +	unsigned int chip_select = f_pdata->cs;
>> +	unsigned int reg;
>> +
>> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +	reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
>> +
>> +	/* Convert CS if without decoder.
>> +	 * CS0 to 4b'1110
>> +	 * CS1 to 4b'1101
>> +	 * CS2 to 4b'1011
>> +	 * CS3 to 4b'0111
>> +	 */
>> +	chip_select = 0xF & ~(1 << chip_select);
> This says "if without decoder" but there's no conditionals here, what if
> we do have a decoder?
Good catch, will add the check in the next patch, the below check to be 
added.
if (cqspi->is_decoded_cs) {
           reg |= CQSPI_REG_CONFIG_DECODE_MASK;
} else {
           reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
>> +	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> +	ddata  = of_device_get_match_data(dev);
>> +	if (ddata) {
>> +		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
>> +			cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>> +						cqspi->master_ref_clk_hz);
>> +		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
>> +			master->mode_bits |= SPI_RX_OCTAL;
>> +		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>> +			cqspi->use_dac_mode = true;
>> +		if (ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) {
>> +			master->bus_num = 0;
>> +			master->num_chipselect = 2;
>> +		}
>> +	}
> Given that the driver appears to unconditionally dereference match data
> in other places I'd expect this to return an error if there's none,
> otherwise we'll oops in those other code paths later on.
Noted, will double check is there any impact if there is no data provided.
also will add the error check if return an error.
>> +	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>> +			       pdev->name, cqspi);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot request IRQ.\n");
>> +		goto probe_reset_failed;
>> +	}
> Are you sure that it's safe to use devm_request_irq()
Yes, I'm sure that it's safe to use devm_request_irq().
>   - what happens if
> the interrupt fires in the process of removing the device?
    This is not external interrupt which is coming from the device, its 
inbuilt to QSPI controller which has 2 Registers 1) INT_STATUS_REG 2) 
INT_MASK_REG.
    It fires an interrupt and updating INT flag bit in the interrupt 
status register once reached read/write completion state then 
irq_handler is called,
    there we are clearing the INT_FLAG bit by masking of RD/WR flag in 
INT_MASK register.

Regards
Vadivel
