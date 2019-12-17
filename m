Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C0122458
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 06:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLQFyk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 00:54:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:58382 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfLQFyj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Dec 2019 00:54:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 21:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,324,1571727600"; 
   d="scan'208";a="221672321"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2019 21:54:36 -0800
Received: from [10.226.38.59] (unknown [10.226.38.59])
        by linux.intel.com (Postfix) with ESMTP id 59A3B580342;
        Mon, 16 Dec 2019 21:54:34 -0800 (PST)
Subject: Re: [PATCH v3 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20191209084035.55603-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191209084035.55603-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <d802642e-253b-cc6f-18ee-9c5e858bd2f9@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <504a8010-38f8-b739-e01a-1250517583e2@linux.intel.com>
Date:   Tue, 17 Dec 2019 13:54:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d802642e-253b-cc6f-18ee-9c5e858bd2f9@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi  Vigensh,

     Thanks for the review and guidance to improve the code a lot.

On 17/12/2019 12:25 PM, Vignesh Raghavendra wrote:
> Hi,
>
> On 09/12/19 2:10 pm, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
>>
>> This driver does not support generic SPI and also the implementation
>> only supports spi-mem interface to replace the existing driver in
>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>> flash memory.
>>
> Patch looks much better.. I will try to test this patch on TI
> platforms... Thanks for doing this! Comments inline...
Thank you :-)
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
> [...]
>> +
>> +static int cqspi_indirect_write_execute(struct struct_cqspi *cqspi,
>> +					const struct spi_mem_op *op,
>> +					const u8 *txbuf)
>> +{
>> +	struct platform_device *pdev = cqspi->pdev;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +	struct cqspi_flash_pdata *f_pdata =
>> +			&pdata->f_pdata[cqspi->current_cs];
>> +	void *reg_base = cqspi->iobase;
>> +	void *ahb_base = cqspi->qspi_ahb_virt;
>> +	u32 page_size = f_pdata->page_size;
>> +	u32 write_bytes, reg = 0;
>> +	int remaining = op->data.nbytes;
>> +	int ret;
>> +
>> +	writel(0xa, reg_base + CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG);
> Does this needs to be done for every write? Can this be moved to
> cqspi_controller_init(). Also use a macro for constants
>
>> +	writel(0x0, reg_base + CQSPI_REG_INDIRECTWRWATERMARK);
> This looks wrong. This was previously set to (cqspi->fifo_depth *
> cqspi->fifo_width / 2). Why do you need to set this to 0? If this needs
> to be 0, setup DT properties as required.
Let me check once it is required or not, then moved to

cqspi_controller_init() function.

>> +	reg = readl(reg_base + CQSPI_REG_SIZE);
>> +	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
>> +	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
>> +	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
>> +	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
>> +	writel(reg, reg_base +  CQSPI_REG_SIZE);
>> +
>> +	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
>> +	writel(CQSPI_REG_SRAM_PARTITION_WR, reg_base + CQSPI_REG_SRAMPARTITION);
>> +	/* Clear all interrupts. */
>> +	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
>> +	writel(CQSPI_IRQ_MASK_WR, reg_base + CQSPI_REG_IRQMASK);
>> +	reinit_completion(&cqspi->transfer_complete);
>> +	writel(CQSPI_REG_INDIRECTWR_START_MASK,
>> +	       reg_base + CQSPI_REG_INDIRECTWR);
>> +
>> +	if (cqspi->wr_delay)
>> +		ndelay(cqspi->wr_delay);
>> +
>> +	while (remaining > 0) {
>> +		size_t write_words, mod_bytes;
>> +
>> +		write_bytes = remaining > page_size ? page_size : remaining;
>> +		write_words = write_bytes / 4;
>> +		mod_bytes = write_bytes % 4;
>> +
>> +		if (write_words) {
>> +			iowrite32_rep(ahb_base, txbuf, write_words);
>> +			txbuf += (write_words * 4);
>> +		}
>> +		if (mod_bytes) {
>> +			unsigned int temp = 0xFFFFFFFF;
>> +
>> +			memcpy(&temp, txbuf, mod_bytes);
>> +			iowrite32(temp, ahb_base);
>> +			txbuf += mod_bytes;
>> +		}
>> +		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
>> +						 msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
>> +			dev_err(&pdev->dev, "Indirect write timeout\n");
>> +			ret = -ETIMEDOUT;
>> +			goto failwr;
>> +		}
>> +		remaining -= write_bytes;
>> +		if (remaining < 0)
>> +			reinit_completion(&cqspi->transfer_complete);
>> +	}
>> +
>> +	/* Check indirect done status */
>> +	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTWR,
>> +				 CQSPI_REG_INDIRECTWR_DONE_MASK, 0);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Indirect write completion error.\n");
>> +		goto failwr;
>> +	}
>> +
>> +	return 0;
>> +
>> +failwr:
>> +	/* Disable interrupt. */
>> +	writel(0, reg_base + CQSPI_REG_IRQMASK);
>> +	/* Clear indirect completion status */
>> +	writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
>> +
>> +	/* Cancel the indirect write */
>> +	if (ret)
>> +		writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
>> +		       reg_base + CQSPI_REG_INDIRECTWR);
>> +
>> +	return ret;
>> +}
>> +
>> +void cqspi_controller_init(struct struct_cqspi *cqspi)
>> +{
>> +	struct platform_device *pdev = cqspi->pdev;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +
>> +	cqspi_controller_enable(cqspi->iobase, 0);
>> +
>> +	/* Configure the remap address register, no remap */
>> +	writel(0, cqspi->iobase + CQSPI_REG_REMAP);
>> +
>> +	/* Disable all interrupts. */
>> +	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
>> +
>> +	/* Load indirect trigger address. */
>> +	writel(pdata->trigger_address,
>> +	       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
>> +
>> +	/* Enable Direct Access Controller */
>> +	if (cqspi->use_dac_mode)
>> +		cqspi_direct_access_enable(cqspi, 1);
>> +
>> +	cqspi_controller_enable(cqspi->iobase, 1);
>> +}
>> +
>> +unsigned int calculate_ticks_for_ns(u32 ref_clk_hz, u32 ns_val)
> Prefix cqspi_ and make the function static
Noted, will fix it.
>> +{
>> +	unsigned int ticks;
>> +
>> +	ticks = ref_clk_hz / 1000;      /* kHz */
>> +	ticks = DIV_ROUND_UP(ticks * ns_val, 1000000);
>> +
>> +	return ticks;
>> +}
>> +
>> +void cqspi_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk_hz)
> static?
Noted, will fixt it.
>> +{
>> +	struct platform_device *pdev = cqspi->pdev;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cqspi->current_cs];
>> +	void __iomem *iobase = cqspi->iobase;
>> +	const unsigned int ref_clk_hz = pdata->master_ref_clk_hz;
>> +	unsigned int tchsh, tshsl, tslch, tsd2d;
>> +	unsigned int reg;
>> +	unsigned int tsclk;
>> +
>> +	cqspi_controller_enable(cqspi->iobase, 0);
>> +	/* calculate the number of ref ticks for one sclk tick */
>> +	tsclk = DIV_ROUND_UP(ref_clk_hz, sclk_hz);
>> +
>> +	/* The controller adds additional delay to that programmed in the reg */
>> +	if (f_pdata->tshsl_ns < tsclk)
>> +		tshsl = tsclk;
>> +
>> +	tchsh = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tchsh_ns);
>> +	tslch = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tslch_ns);
>> +	tsd2d = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tsd2d_ns);
>> +	tshsl = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tshsl_ns);
>> +
>> +	reg = ((tshsl & CQSPI_REG_DELAY_TSHSL_MASK)
>> +			<< CQSPI_REG_DELAY_TSHSL_LSB);
>> +	reg |= ((tchsh & CQSPI_REG_DELAY_TCHSH_MASK)
>> +			<< CQSPI_REG_DELAY_TCHSH_LSB);
>> +	reg |= ((tslch & CQSPI_REG_DELAY_TSLCH_MASK)
>> +			<< CQSPI_REG_DELAY_TSLCH_LSB);
>> +	reg |= ((tsd2d & CQSPI_REG_DELAY_TSD2D_MASK)
>> +			<< CQSPI_REG_DELAY_TSD2D_LSB);
>> +	writel(reg, iobase + CQSPI_REG_DELAY);
>> +	cqspi_controller_enable(cqspi->iobase, 1);
>> +}
>> +
>> +void cqspi_switch_chipselect(struct struct_cqspi *cqspi, u32 cs)
> static?
Noted, will fixt it.
>> +{
>> +	struct platform_device *pdev = cqspi->pdev;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cs];
>> +	void __iomem *iobase = cqspi->iobase;
>> +	unsigned int reg;
>> +
>> +	cqspi_controller_enable(cqspi->iobase, 0);
>> +	/* Configure page size and block size. */
>> +	reg = readl(iobase + CQSPI_REG_SIZE);
>> +	/* clear the previous value */
>> +	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
>> +	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
>> +	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
>> +	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
>> +	writel(reg, iobase + CQSPI_REG_SIZE);
>> +	/* configure the chip select */
>> +	cqspi_chip_select(iobase, cs, pdata->ext_decoder);
>> +	cqspi_controller_enable(cqspi->iobase, 1);
>> +}
>> +
>> +static int cqspi_apb_read_execute(struct struct_cqspi *cqspi,
>> +				  const struct spi_mem_op *op, u8 *rxbuf)
>> +{
>> +	u32 from = op->addr.val;
>> +	void *buf = op->data.buf.in;
>> +	size_t len = op->data.nbytes;
>> +
>> +	if (cqspi->use_dac_mode && (from + len < cqspi->ahb_size)) {
>> +		memcpy_fromio(buf, cqspi->ahbbase + from, len);
> Hmm, You have dropped DMA support... This will be a regression :(
sorry , dont have the setup so understood the code , accordingly changed .
>> +		if (!cqspi_wait_idle(cqspi))
>> +			return -EIO;
>> +		return 0;
>> +	}
>> +
>> +	return cqspi_indirect_read_execute(cqspi, op, rxbuf);
>> +}
>> +
>> +int cqspi_apb_write_execute(struct struct_cqspi *cqspi,
>> +			    const struct spi_mem_op *op, const u8 *txbuf)
> static? Please make all functions static if they are local to the module.
Noted, will fixt it.
>> +{
>> +	u32 to = op->addr.val;
>> +	const void *buf = op->data.buf.out;
>> +	size_t len = op->data.nbytes;
>> +
>> +	if (cqspi->use_dac_mode && (to + len < cqspi->ahb_size)) {
>> +		memcpy_toio(cqspi->ahbbase + to, buf, len);
>> +		if (!cqspi_wait_idle(cqspi))
>> +			return -EIO;
>> +		return 0;
>> +	}
>> +
>> +	return cqspi_indirect_write_execute(cqspi, op, txbuf);
>> +}
>> +
>> +static int cqspi_mem_process(struct struct_cqspi *cqspi, struct spi_mem *mem,
>> +			     const struct spi_mem_op *op)
>> +{
>> +	struct platform_device *pdev = cqspi->pdev;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +	unsigned int tmpbufsize, n_trans = 0, totalxferlen = 0;
>> +	void __iomem *iobase = cqspi->iobase;
>> +	struct spi_mem_op_cadence ops[4] = { };
>> +	struct spi_mem_op_cadence *cmd_ops = NULL;
>> +	struct spi_mem_op_cadence *data_ops = NULL;
>> +	struct spi_mem_op_cadence *dummy_ops = NULL;
>> +	struct spi_mem_op_cadence *addr_ops = NULL;
>> +	struct cqspi_flash_pdata *f_pdata;
>> +	int mode, err, i;
>> +	u8 *tmpbuf;
>> +	u32 sclk;
>> +
>> +	if (cqspi->current_cs != mem->spi->chip_select) {
>> +		cqspi->current_cs = mem->spi->chip_select;
>> +		cqspi_switch_chipselect(cqspi, mem->spi->chip_select);
>> +	}
>> +
>> +	f_pdata = &pdata->f_pdata[cqspi->current_cs];
>> +
>> +	tmpbufsize = sizeof(op->cmd.opcode) + op->addr.nbytes +
>> +			op->dummy.nbytes;
>> +
>> +	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
> I don't understand the need for this buffer and spi_mem_op_cadence..
> Since, struct spi_mem_op is anyways passed at all places where
> cmd/data/addr_ops are being used. I think its possible to drop them...
> See below
while testing crash happened that's the reason , kept it.
>> +	if (!tmpbuf)
>> +		return -ENOMEM;
>> +
>> +	tmpbuf[0] = op->cmd.opcode;
>> +	ops[n_trans].tx_buf = tmpbuf;
>> +	ops[n_trans].len = sizeof(op->cmd.opcode);
>> +	ops[n_trans].tx_nbits = op->cmd.buswidth;
>> +
>> +	n_trans++;
>> +	totalxferlen++;
>> +
>> +	if (op->addr.nbytes) {
>> +		int i;
>> +
>> +		for (i = 0; i < op->addr.nbytes; i++)
>> +			tmpbuf[i + 1] = op->addr.val >>
>> +					(8 * (op->addr.nbytes - i - 1));
>> +
> cqspi_cmd2addr()?

Address alignment for data (read/write) operation in user area, mainly 
kept this to avoid functionality breakage,

checked other drivers as well which you have referred, same thing they 
are also doing for aligment of data access.

>> +		ops[n_trans].tx_buf = tmpbuf + 1;
>> +		ops[n_trans].len = op->addr.nbytes;
>> +		ops[n_trans].tx_nbits = op->addr.buswidth;
>> +
>> +		n_trans++;
>> +		totalxferlen += op->addr.nbytes;
>> +	}
>> +	if (op->dummy.nbytes) {
>> +		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
>> +		ops[n_trans].tx_buf = tmpbuf + op->addr.nbytes + 1;
>> +		ops[n_trans].len = op->dummy.nbytes;
>> +		ops[n_trans].tx_nbits = op->dummy.buswidth;
>> +
>> +		n_trans++;
>> +		totalxferlen += op->dummy.nbytes;
>> +	}
>> +	if (op->data.nbytes) {
>> +		if (op->data.dir == SPI_MEM_DATA_IN) {
>> +			ops[n_trans].rx_buf = op->data.buf.in;
>> +			ops[n_trans].rx_nbits = op->data.buswidth;
>> +		} else {
>> +			ops[n_trans].tx_buf = op->data.buf.out;
>> +			ops[n_trans].tx_nbits = op->data.buswidth;
>> +		}
>> +
>> +		ops[n_trans].len = op->data.nbytes;
>> +		n_trans++;
>> +		totalxferlen += op->data.nbytes;
>> +	}
>> +
>> +	for (i = 0; i < n_trans; i++)
>> +		dev_dbg(&pdev->dev, "ops[%d] %d\n", i, ops[i].len);
>> +
>> +	switch (n_trans) {
>> +	case 1:
>> +		cmd_ops = &ops[0];
> I don't see any cmd_ops being consumed anywhere. So clearly this can be
> dropped,
Noted, will fixt it.
>> +		break;
>> +	case 2:
>> +		cmd_ops = &ops[0];
>> +		data_ops = &ops[1];
>> +		break;
>> +	case 3:
>> +		cmd_ops = &ops[0];
>> +		addr_ops = &ops[1];
>> +		data_ops = &ops[2];
>> +		break;
>> +	case 4:
>> +		cmd_ops = &ops[0];
>> +		addr_ops = &ops[1];
>> +		dummy_ops = &ops[2];
>> +		data_ops = &ops[3];
>> +		break;
>> +	default:
>> +		dev_err(&pdev->dev, "Unsupported n_trans %u\n", n_trans);
>> +		return -EINVAL;
>> +	}
>> +	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
>> +		if (!op->addr.nbytes)
>> +			mode = CQSPI_STIG_READ;
>> +		else
>> +			mode = CQSPI_INDIRECT_READ;
> Drop INDIRECT in the name... Driver supports both the modes.
Noted, will fixt it.
>> +	} else {
>> +		if (!op->addr.nbytes || !op->data.buf.out)
>> +			mode = CQSPI_STIG_WRITE;
>> +		else
>> +			mode = CQSPI_INDIRECT_WRITE;
> Same here...
Noted, will fixt it.
>> +	}
>> +
>> +	sclk = mem->spi->max_speed_hz;
>> +	cqspi_controller_enable(iobase, 0);
>> +	cqspi_config_baudrate_div(iobase, pdata->master_ref_clk_hz, sclk);
>> +	cqspi_delay(cqspi, pdata->master_ref_clk_hz, sclk);
>> +	cqspi_readdata_capture(iobase, 1, f_pdata->read_delay);
>> +	cqspi_controller_enable(iobase, 1);
>> +
>> +	/* execute transfer */
>> +	switch (mode) {
>> +	case CQSPI_STIG_WRITE:
>> +		err = cqspi_command_write(cqspi, op);
>> +		if (err) {
>> +			dev_err(&pdev->dev, "QSPI: Command Write failed!.\n");
>> +			return err;
>> +		}
>> +		break;
>> +	case CQSPI_STIG_READ:
>> +		err = cqspi_command_read(cqspi, op);
>> +		if (err) {
>> +			dev_err(&pdev->dev, "QSPI: Command Read failed!.\n");
>> +			return err;
>> +		}
>> +		break;
>> +	case CQSPI_INDIRECT_WRITE:
>> +		err = cqspi_indirect_write_setup(cqspi, op, addr_ops->tx_buf);
> No need for addr_ops, just move the logic associated with it into above
> function.
> Also rename above function to drop reference to indirect mode
Noted, will fixt it.
>> +		err = cqspi_apb_write_execute(cqspi, op, data_ops->tx_buf);
>
> Instead of data_ops, why not just use op->data.buf.out inside
> cqspi_apb_write_execute()?
Noted, will fixt it.
>> +		if (err) {
>> +			dev_err(&pdev->dev, "QSPI: Write Execution failed!.\n");
>> +			return err;
>> +		}
>> +		break;
>> +	case CQSPI_INDIRECT_READ:
>> +		err = cqspi_indirect_read_setup(cqspi, op, addr_ops->tx_buf);
> Same as above
>
>> +		err = cqspi_apb_read_execute(cqspi, op, data_ops->rx_buf);
> Instead of data_ops, why not just use op->data.buf.in inside
> cqspi_apb_read_execute()?
>
>> +		if (err) {
>> +			dev_err(&pdev->dev, "QSPI: Read Execution failed!.\n");
>> +			return err;
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(&pdev->dev, "Unsupported mode %u\n", mode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct struct_cqspi *cqspi = spi_master_get_devdata(mem->spi->master);
>> +	int ret;
>> +
>> +	mutex_lock(&cqspi->lock);
>> +	ret = cqspi_mem_process(cqspi, mem, op);
>> +	if (ret)
>> +		dev_err(&mem->spi->dev, "QSPI: qspi transfer failed!!!.\n");
>> +	mutex_unlock(&cqspi->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct spi_controller_mem_ops cqspi_mem_ops = {
>> +	.exec_op = cqspi_exec_mem_op,
>> +};
>> +
>> +static int cqspi_setup(struct spi_device *spi)
>> +{
>> +	if (spi->chip_select > spi->master->num_chipselect) {
>> +		dev_err(&spi->dev, "QSPI: chip_select is out of range\n");
>> +		return -EINVAL;
>> +	}
> This is where driver should setup flash_pdata (i.e call
> cqspi_of_get_flash_pdata() here)
>
Noted, will fixt it.
>
>> +	return 0;
>> +}
>> +
>> +static int cqspi_of_get_flash_pdata(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct device_node *nc;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +	struct cqspi_flash_pdata *f_pdata;
>> +	u32 prop, cs;
>> +
>> +	/* Get flash devices platform data */
>> +	for_each_child_of_node(np, nc) {
>> +		if (!of_device_is_available(nc))
>> +			continue;
>> +
>> +		if (of_property_read_u32(nc, "reg", &cs)) {
>> +			dev_err(&pdev->dev, "couldn't determine reg\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata = &pdata->f_pdata[cs];
>> +
>> +		if (of_property_read_u32(nc, "cdns,read-delay", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine read-delay\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->read_delay = prop;
>> +
>> +		if (of_property_read_u32(nc, "cdns,tshsl-ns", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine tshsl-ns\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->tshsl_ns = prop;
>> +
>> +		if (of_property_read_u32(nc, "cdns,tsd2d-ns", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine tsd2d-ns\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->tsd2d_ns = prop;
>> +
>> +		if (of_property_read_u32(nc, "cdns,tchsh-ns", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine tchsh-ns\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->tchsh_ns = prop;
>> +
>> +		if (of_property_read_u32(nc, "cdns,tslch-ns", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine tslch-ns\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->tslch_ns = prop;
>> +
>> +		if (of_property_read_u32(nc, "page-size", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine page-size\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->page_size = prop;
>> +
>> +		if (of_property_read_u32(nc, "block-size", &prop)) {
>> +			dev_err(&pdev->dev, "couldn't determine block-size\n");
>> +			return -ENXIO;
>> +		}
>> +		f_pdata->block_size = prop;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int cqspi_of_get_pdata(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
>> +	unsigned int prop;
>> +	int ret;
>> +
>> +	pdata->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
>> +
>> +	if (of_property_read_u32(np, "cdns,fifo-depth", &prop)) {
>> +		dev_err(&pdev->dev, "couldn't determine fifo-depth\n");
>> +		return -ENXIO;
>> +	}
>> +	pdata->fifo_depth = prop;
>> +
>> +	if (of_property_read_u32(np, "cdns,fifo-width", &prop)) {
>> +		dev_err(&pdev->dev, "couldn't determine fifo-width\n");
>> +		return -ENXIO;
>> +	}
>> +	pdata->fifo_width = prop;
>> +
>> +	if (of_property_read_u32(np, "cdns,trigger-address", &prop)) {
>> +		dev_err(&pdev->dev, "couldn't determine trigger-address\n");
>> +		return -ENXIO;
>> +	}
>> +	pdata->trigger_address = prop;
>> +
>> +	pdata->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
>> +
>> +	ret = cqspi_of_get_flash_pdata(pdev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Get flash data failed.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cqspi_probe(struct platform_device *pdev)
>> +{
>> +	struct cqspi_platform_data *pdata;
>> +	struct device *dev = &pdev->dev;
>> +	struct struct_cqspi *cqspi;
>> +	struct spi_master *master;
>> +	struct reset_control *rstc, *rstc_ocp;
>> +	const struct cqspi_driver_platdata *ddata;
>> +	struct resource *res = NULL;
>> +	int ret;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
>> +	if (!master) {
>> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");
>> +		return -ENOMEM;
>> +	}
>> +	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA | SPI_TX_QUAD |
>> +			    SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL |
>> +			    SPI_TX_OCTAL | SPI_RX_OCTAL;
> Driver does not support Multi IO TX, so lets drop SPI_TX_DUAL,
> SPI_TX_QUAD and SPI_TX_OCTAL for now. No support for changing polarity,
> phase or inverted CS (although IP may support these) either... So this
> should be
>
> 	master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL |	SPI_RX_OCTAL;
Noted, will fixt it.
>> +	master->setup = cqspi_setup;
>> +	master->mem_ops = &cqspi_mem_ops;
>> +	master->dev.of_node = pdev->dev.of_node;
>> +	cqspi = spi_master_get_devdata(master);
>> +	cqspi->pdev = pdev;
>> +
>> +	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
> Use devm_kmalloc()
Noted, will fixt it.
>> +	if (!pdata) {
>> +		ret = -ENOMEM;
>> +		goto err_pdata;
>> +	}
>> +	pdev->dev.platform_data = pdata;
>> +
>> +	/* Obtain QSPI clock. */
>> +	cqspi->clk = devm_clk_get(&pdev->dev, "qspi");
>> +	if (IS_ERR(cqspi->clk)) {
>> +		dev_err(&pdev->dev, "cannot get qspi clk\n");
>> +		return PTR_ERR(cqspi->clk);
>> +	}
>> +	pdata->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> +
>> +	ret = clk_prepare_enable(cqspi->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to enable qspi clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Obtain configuration from OF. */
>> +	ret = cqspi_of_get_pdata(pdev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Get platform data failed.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cqspi->res = res;
>> +	/* Obtain and remap controller address. */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	cqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(cqspi->iobase)) {
>> +		dev_err(dev, "Cannot remap controller address.\n");
>> +		return PTR_ERR(cqspi->iobase);
>> +	}
>> +
>> +	/* Obtain and remap AHB address. */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	cqspi->qspi_ahb_virt = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(cqspi->qspi_ahb_virt)) {
>> +		dev_err(dev, "Cannot remap AHB address.\n");
>> +		return PTR_ERR(cqspi->qspi_ahb_virt);
>> +	}
>> +	cqspi->ahbbase = res;
>> +	cqspi->ahb_size = resource_size(res);
>> +
>> +	/* Obtain QSPI reset control */
>> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
>> +	if (IS_ERR(rstc)) {
>> +		dev_err(dev, "Cannot get QSPI reset.\n");
>> +		return PTR_ERR(rstc);
>> +	}
>> +
>> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
>> +	if (IS_ERR(rstc_ocp)) {
>> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
>> +		return PTR_ERR(rstc_ocp);
>> +	}
>> +
>> +	reset_control_assert(rstc);
>> +	reset_control_deassert(rstc);
>> +
>> +	reset_control_assert(rstc_ocp);
>> +	reset_control_deassert(rstc_ocp);
>> +
>> +	ddata  = of_device_get_match_data(dev);
>> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
>> +		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>> +						   pdata->master_ref_clk_hz);
>> +
>> +	if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>> +		cqspi->use_dac_mode = false;
>> +
>> +	init_completion(&cqspi->transfer_complete);
>> +
>> +	/* Obtain IRQ line. */
>> +	cqspi->irq = platform_get_irq(pdev, 0);
>> +	if (cqspi->irq < 0) {
>> +		dev_err(dev, "platform_get_irq failed.\n");
>> +		ret = -ENXIO;
>> +		goto err_irq;
>> +	}
>> +	ret = devm_request_irq(dev, cqspi->irq, cqspi_irq_handler, 0,
>> +			       pdev->name, cqspi);
>> +	if (ret) {
>> +		dev_err(dev, "request_irq failed.\n");
>> +		goto err_irq;
>> +	}
>> +
>> +	master->bus_num = pdata->bus_num;
>> +	master->num_chipselect = pdata->num_chipselect;
>> +	mutex_init(&cqspi->lock);
>> +	platform_set_drvdata(pdev, master);
>> +	cqspi_controller_init(cqspi);
>> +	cqspi->current_cs = -1;
>> +
>> +	ret = devm_spi_register_master(dev, master);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "devm_spi_register_master failed.\n");
>> +		goto err_of;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_pdata:
>> +	kfree(pdata);
> Can be dropped if pdata is devm_kmalloc'd
Noted, will fixt it.
>> +err_irq:
>> +	free_irq(cqspi->irq, cqspi);
> No need to free explicitly.... IRQ was requested as devm_request_irq()
Noted, will remove it.
>> +err_of:
>> +	spi_master_put(master);
>> +	dev_err(&pdev->dev, "Cadence QSPI controller probe failed\n");
>> +	return ret;
>> +}
>> +
>> +static int cqspi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_master *master = platform_get_drvdata(pdev);
>> +	struct struct_cqspi *cadence_qspi = spi_master_get_devdata(master);
>> +
>> +	cqspi_controller_enable(cadence_qspi->iobase, 0);
>
>> +	platform_set_drvdata(pdev, NULL);
>> +	free_irq(cadence_qspi->irq, cadence_qspi);
>> +	iounmap(cadence_qspi->iobase);
>> +	iounmap(cadence_qspi->qspi_ahb_virt);
>> +	release_mem_region(cadence_qspi->res->start,
>> +			   resource_size(cadence_qspi->res));
>> +	kfree(pdev->dev.platform_data);
>> +	spi_unregister_master(master);
>> +	spi_master_put(master);
> No need for any of these... Since, these resources are allocated (or
> registered) using devm_* APIs, they are freed automatically on remove.
>
Agreed!!
>> +	return 0;
>> +}
>> +
>> +static const struct cqspi_driver_platdata k2g_qspi = {
>> +	.quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>> +static const struct cqspi_driver_platdata am654_ospi = {
>> +	.quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
>> +	.quirks = CQSPI_DISABLE_DAC_MODE,
>> +};
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id cqspi_of_match[] = {
>> +	{
>> +		.compatible = "cadence,qspi",
>> +	},
>> +	{
>> +		.compatible = "ti,k2g-qspi",
>> +		.data = &k2g_qspi,
>> +	},
>> +	{
>> +		.compatible = "ti,am654-ospi",
>> +		.data = &am654_ospi,
>> +	},
>> +	{
>> +		.compatible = "intel,lgm-qspi",
>> +		.data = &intel_lgm_qspi,
>> +	},
>> +	{ /* end of table */}
>> +};
>> +MODULE_DEVICE_TABLE(of, cqspi_of_match);
>> +#else
>> +#define cqspi_of_match NULL
>> +#endif /* CONFIG_OF */
>> +
>> +static struct platform_driver cqspi_platform_driver = {
>> +	.probe          = cqspi_probe,
>> +	.remove         = cqspi_remove,
>> +	.driver = {
>> +		.name   = CADENCE_QSPI_NAME,
>> +		.of_match_table = cqspi_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(cqspi_platform_driver);
>> +
>> +MODULE_DESCRIPTION("Cadence QSPI Controller Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" CADENCE_QSPI_NAME);
>> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
>> +MODULE_AUTHOR("Graham Moore <grmoore@opensource.altera.com>");
>> +MODULE_AUTHOR("Vadivel Murugan R <vadivel.muruganx.ramuthevar@intel.com>");
>> diff --git a/drivers/spi/spi-cadence-quadspi.h b/drivers/spi/spi-cadence-quadspi.h
>> new file mode 100644
>> index 000000000000..e306b30e4d03
>> --- /dev/null
>> +++ b/drivers/spi/spi-cadence-quadspi.h
>> @@ -0,0 +1,251 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Driver for Cadence QSPI Controller
>> + *
>> + * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
>> + * Copyright Intel Corporation (C) 2019-2020. All rights reserved.
>> + */
>> +#ifndef __CADENCE_QSPI__H__
>> +#define __CADENCE_QSPI__H__
>> +#include <linux/reset.h>
>> +#include <linux/spi/spi-mem.h>
>> +
>> +#define CQSPI_MAX_CHIP_SELECT		(16)
>> +#define CQSPI_STIG_READ			1
>> +#define CQSPI_STIG_WRITE		2
>> +#define CQSPI_INDIRECT_READ		3
>> +#define CQSPI_INDIRECT_WRITE		4
>> +
>> +#define QUAD_SIO			0
>> +#define QUAD_DIO			1
>> +#define QUAD_QIO			2
>> +
>> +#define QUAD_LSB			4
>> +
> Drop unused constants, please... I don't see a need to add any more
> constants than whats already present in old driver...
Noted, will fixt it.
>> +/* Operation timeout value */
>> +#define CQSPI_TIMEOUT_MS			5000
>> +#define CQSPI_READ_TIMEOUT_MS			10
>> +#define CQSPI_POLL_IDLE_RETRY			3
>> +#define CQSPI_FIFO_WIDTH			4
>> +
>> +/* Controller sram size in word */
>> +#define CQSPI_REG_SRAM_RESV_WORDS		2
>> +#define CQSPI_REG_SRAM_PARTITION_WR		1
>> +#define CQSPI_REG_SRAM_THRESHOLD_BYTES		50
>> +
>> +/* Instruction type */
>> +#define CQSPI_INST_TYPE_SINGLE			0
>> +#define CQSPI_INST_TYPE_DUAL			1
>> +#define CQSPI_INST_TYPE_QUAD			2
>> +#define CQSPI_DUMMY_CLKS_PER_BYTE		8
>> +#define CQSPI_DUMMY_BYTES_MAX			4
>> +#define CQSPI_STIG_DATA_LEN_MAX			8
>> +#define CQSPI_INDIRECTTRIGGER_ADDR_MASK		0xFFFFF
>> +
>> +/* Register map */
>> +#define	CQSPI_REG_CONFIG			0x00
>> +#define	CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
>> +#define	CQSPI_REG_CONFIG_DIRECT_MASK		BIT(7)
>> +#define	CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
>> +#define	CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
>> +#define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
>> +#define	CQSPI_REG_CONFIG_BAUD_LSB		19
>> +#define	CQSPI_REG_CONFIG_IDLE_LSB		31
>> +#define	CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
>> +#define	CQSPI_REG_CONFIG_BAUD_MASK		0xF
>> +#define	CQSPI_REG_RD_INSTR			0x04
>> +#define	CQSPI_REG_RD_INSTR_OPCODE_LSB		0
>> +#define	CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB	8
>> +#define	CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB	12
>> +#define	CQSPI_REG_RD_INSTR_TYPE_DATA_LSB	16
>> +#define	CQSPI_REG_RD_INSTR_MODE_EN_LSB		20
>> +#define	CQSPI_REG_RD_INSTR_DUMMY_LSB		24
>> +#define	CQSPI_REG_RD_INSTR_TYPE_INSTR_MASK	0x3
>> +#define	CQSPI_REG_RD_INSTR_TYPE_ADDR_MASK	0x3
>> +#define	CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
>> +#define	CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
>> +#define	CQSPI_REG_WR_INSTR			0x08
>> +#define	CQSPI_REG_WR_INSTR_OPCODE_LSB		0
>> +#define	CQSPI_REG_WR_INSTR_TYPE_DATA_MASK	0x3
>> +#define	CQSPI_REG_WR_INSTR_TYPE_DATA_LSB	16
>> +#define	CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK	0x3
>> +#define	CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
>> +
>> +/*! Field WEL_DIS_FLD - wel_dis_fld */
>> +#define CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS	8
>> +#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
>> +#define CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS	14
>> +
>> +#define	CQSPI_REG_DELAY				0x0C
>> +#define	CQSPI_REG_DELAY_TSLCH_LSB		0
>> +#define	CQSPI_REG_DELAY_TCHSH_LSB		8
>> +#define	CQSPI_REG_DELAY_TSD2D_LSB		16
>> +#define	CQSPI_REG_DELAY_TSHSL_LSB		24
>> +#define	CQSPI_REG_DELAY_TSLCH_MASK		0xFF
>> +#define	CQSPI_REG_DELAY_TCHSH_MASK		0xFF
>> +#define	CQSPI_REG_DELAY_TSD2D_MASK		0xFF
>> +#define	CQSPI_REG_DELAY_TSHSL_MASK		0xFF
>> +#define	CQSPI_REG_READCAPTURE			0x10
>> +#define	CQSPI_REG_READCAPTURE_BYPASS_LSB	0
>> +#define	CQSPI_REG_READCAPTURE_DELAY_LSB		1
>> +#define	CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
>> +#define	CQSPI_REG_SIZE				0x14
>> +#define	CQSPI_REG_SIZE_ADDRESS_LSB		0
>> +#define	CQSPI_REG_SIZE_PAGE_LSB			4
>> +#define	CQSPI_REG_SIZE_BLOCK_LSB		16
>> +#define	CQSPI_REG_SIZE_ADDRESS_MASK		0xF
>> +#define	CQSPI_REG_SIZE_PAGE_MASK		0xFFF
>> +#define	CQSPI_REG_SIZE_BLOCK_MASK		0x3F
>> +#define	CQSPI_REG_SRAMPARTITION			0x18
>> +#define	CQSPI_REG_INDIRECTTRIGGER		0x1C
>> +#define	CQSPI_REG_DMA				0x20
>> +#define	CQSPI_REG_DMA_SINGLE_LSB		0
>> +#define	CQSPI_REG_DMA_BURST_LSB			8
>> +#define	CQSPI_REG_DMA_SINGLE_MASK		0xFF
>> +#define	CQSPI_REG_DMA_BURST_MASK		0xFF
>> +#define	CQSPI_REG_REMAP				0x24
>> +#define	CQSPI_REG_MODE_BIT			0x28
>> +#define	CQSPI_REG_SDRAMLEVEL			0x2C
>> +#define	CQSPI_REG_SDRAMLEVEL_RD_LSB		0
>> +#define	CQSPI_REG_SDRAMLEVEL_WR_LSB		16
>> +#define	CQSPI_REG_SDRAMLEVEL_RD_MASK		0xFFFF
>> +#define	CQSPI_REG_SDRAMLEVEL_WR_MASK		0xFFFF
>> +
>> +#define	CQSPI_REG_IRQSTATUS			0x40
>> +#define	CQSPI_REG_IRQMASK			0x44
>> +#define	CQSPI_REG_INDIRECTRD			0x60
>> +#define	CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
>> +#define	CQSPI_REG_INDIRECTRD_CANCEL_MASK	BIT(1)
>> +#define	CQSPI_REG_INDIRECTRD_DONE_MASK		BIT(5)
>> +#define	CQSPI_REG_INDIRECTRDWATERMARK		0x64
>> +#define	CQSPI_REG_INDIRECTRDSTARTADDR		0x68
>> +#define	CQSPI_REG_INDIRECTRDBYTES		0x6C
>> +#define CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG	0x80
>> +#define	CQSPI_REG_CMDCTRL			0x90
>> +#define	CQSPI_REG_CMDCTRL_EXECUTE_MASK		BIT(0)
>> +#define	CQSPI_REG_CMDCTRL_INPROGRESS_MASK	BIT(1)
>> +#define	CQSPI_REG_CMDCTRL_WR_BYTES_LSB		12
>> +#define	CQSPI_REG_CMDCTRL_WR_EN_LSB		15
>> +#define	CQSPI_REG_CMDCTRL_ADD_BYTES_LSB		16
>> +#define	CQSPI_REG_CMDCTRL_ADDR_EN_LSB		19
>> +#define	CQSPI_REG_CMDCTRL_RD_BYTES_LSB		20
>> +#define	CQSPI_REG_CMDCTRL_RD_EN_LSB		23
>> +#define	CQSPI_REG_CMDCTRL_OPCODE_LSB		24
>> +#define	CQSPI_REG_CMDCTRL_WR_BYTES_MASK		0x7
>> +#define	CQSPI_REG_CMDCTRL_ADD_BYTES_MASK	0x3
>> +#define	CQSPI_REG_CMDCTRL_RD_BYTES_MASK		0x7
>> +#define	CQSPI_REG_INDIRECTWR			0x70
>> +#define	CQSPI_REG_INDIRECTWR_START_MASK		BIT(0)
>> +#define	CQSPI_REG_INDIRECTWR_CANCEL_MASK	BIT(1)
>> +#define	CQSPI_REG_INDIRECTWR_DONE_MASK		BIT(5)
>> +#define	CQSPI_REG_INDIRECTWRWATERMARK		0x74
>> +#define	CQSPI_REG_INDIRECTWRSTARTADDR		0x78
>> +#define	CQSPI_REG_INDIRECTWRBYTES		0x7C
>> +#define	CQSPI_REG_CMDADDRESS			0x94
>> +#define	CQSPI_REG_CMDREADDATALOWER		0xA0
>> +#define	CQSPI_REG_CMDREADDATAUPPER		0xA4
>> +#define	CQSPI_REG_CMDWRITEDATALOWER		0xA8
>> +#define	CQSPI_REG_CMDWRITEDATAUPPER		0xAC
>> +
>> +/* Interrupt status bits */
>> +#define CQSPI_REG_IRQ_MODE_ERR			BIT(0)
>> +#define CQSPI_REG_IRQ_UNDERFLOW			BIT(1)
>> +#define CQSPI_REG_IRQ_IND_COMP			BIT(2)
>> +#define CQSPI_REG_IRQ_IND_RD_REJECT		BIT(3)
>> +#define CQSPI_REG_IRQ_WR_PROTECTED_ERR		BIT(4)
>> +#define CQSPI_REG_IRQ_ILLEGAL_AHB_ERR		BIT(5)
>> +#define CQSPI_REG_IRQ_WATERMARK			BIT(6)
>> +#define CQSPI_REG_IRQ_IND_RD_OVERFLOW		BIT(12)
>> +#define CQSPI_IRQ_STATUS_ERR		(CQSPI_REG_IRQ_MODE_ERR		| \
>> +					 CQSPI_REG_IRQ_IND_RD_REJECT	| \
>> +					 CQSPI_REG_IRQ_WR_PROTECTED_ERR	| \
>> +					 CQSPI_REG_IRQ_ILLEGAL_AHB_ERR)
>> +#define CQSPI_IRQ_MASK_RD		(CQSPI_REG_IRQ_MODE_ERR		| \
>> +					 CQSPI_REG_IRQ_IND_RD_REJECT	| \
>> +					 CQSPI_REG_IRQ_WATERMARK	| \
>> +					 CQSPI_REG_IRQ_IND_RD_OVERFLOW	| \
>> +					 CQSPI_REG_IRQ_IND_COMP)
>> +#define CQSPI_IRQ_MASK_WR		(CQSPI_REG_IRQ_MODE_ERR		| \
>> +					 CQSPI_REG_IRQ_WR_PROTECTED_ERR	| \
>> +					 CQSPI_REG_IRQ_IND_COMP		| \
>> +					 CQSPI_REG_IRQ_WATERMARK	| \
>> +					 CQSPI_REG_IRQ_UNDERFLOW)
>> +
>> +#define CQSPI_IRQ_STATUS_MASK			(0xFFFFFFFF)
>> +#define CQSPI_CAL_DELAY(tdelay_ns, tref_ns, tsclk_ns)		\
>> +		((((tdelay_ns) - (tsclk_ns)) / (tref_ns)))
>> +#define CQSPI_GET_RD_SRAM_LEVEL(reg_basse)			\
>> +		(((readl(reg_base + CQSPI_REG_SDRAMLEVEL)) >>	\
>> +		CQSPI_REG_SDRAMLEVEL_RD_LSB) & CQSPI_REG_SDRAMLEVEL_RD_MASK)
>> +
>> +struct cqspi_flash_pdata {
>> +	u32	page_size;
>> +	u32	block_size;
>> +	u32	flash_type;
>> +	u32	quad;
>> +	u32	read_delay;
>> +	u32	tshsl_ns;
>> +	u32	tsd2d_ns;
>> +	u32	tchsh_ns;
>> +	u32	tslch_ns;
>> +};
>> +
>> +struct cqspi_platform_data {
>> +	u32	bus_num;
>> +	u32	num_chipselect;
>> +	u32	qspi_ahb_phy;
>> +	u32	qspi_ahb_size;
>> +	u32	qspi_ahb_mask;
>> +	u32	master_ref_clk_hz;
>> +	u32	ext_decoder;
>> +	u32	fifo_depth;
>> +	u32	fifo_width;
>> +	u32	enable_dma;
>> +	u32	tx_dma_peri_id;
>> +	u32	rx_dma_peri_id;
>> +	u32	trigger_address;
>> +	bool	is_decoded_cs;
>> +	bool	rclk_en;
>> +	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIP_SELECT];
>> +};
>> +
>> +struct struct_cqspi {
>> +	struct platform_device	*pdev;
>> +
>> +	struct clk		*clk;
>> +	struct clk		*fpi_clk;
>> +
>> +	struct reset_control	*reset;
>> +	struct completion	transfer_complete;
>> +	struct workqueue_struct	*workqueue;
>> +	wait_queue_head_t	waitqueue;
>> +	/* mutex lock for synchronization */
>> +	struct mutex		lock;
>> +
>> +	void __iomem		*iobase;
>> +	void __iomem		*qspi_ahb_virt;
>> +	struct resource		*res;
>> +	struct resource		*ahbbase;
>> +	resource_size_t		ahb_size;
>> +
>> +	struct dma_chan		*rx_chan;
>> +	struct completion       rx_dma_complete;
>> +	dma_addr_t		mmap_phys_base;
>> +	int			dma_done;
>> +	u32			trigger_address;
>> +	u32			wr_delay;
>> +	u32			irq_status;
>> +	int			current_cs;
>> +	int			irq;
>> +	bool			use_dac_mode;
>> +};
>> +
>> +struct spi_mem_op_cadence {
>> +	const void	*tx_buf;
>> +	void		*rx_buf;
>> +	u32		len;
>> +	u32		tx_nbits:3;
>> +	u32		rx_nbits:3;
>> +};
>> +
>> +#endif /* __CADENCE_QSPI__H__ */
>>
