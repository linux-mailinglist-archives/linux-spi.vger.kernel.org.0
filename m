Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67641D53CD
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEOPLB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:11:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:14565 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgEOPLA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 11:11:00 -0400
IronPort-SDR: yoU+F+CfxkujnYJGYmEod6KxOQYp1Ki05eKikZrzIYHzv4pt5jmw9s/4yYyxH5xzu00EELkX0+
 FUko6Ps5tYjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 08:11:00 -0700
IronPort-SDR: qprBBQ4n1jaNuRdgVC2ibo+ekVIFl1EtqI+ZtvszsI6UFL/hj2nylNExKzaU61kUs0WUoBRKpa
 c71LVxyqNTFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="307445063"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2020 08:10:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbzE-006tYd-BD; Fri, 15 May 2020 18:10:56 +0300
Date:   Fri, 15 May 2020 18:10:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Clement Leger <cleger@kalray.eu>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/19] spi: dw: Use regset32 DebugFS method to create
 regdump file
Message-ID: <20200515151056.GQ1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-19-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-19-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:57PM +0300, Serge Semin wrote:
> DebugFS kernel interface provides a dedicated method to create the
> registers dump file. Use it instead of creating a generic DebugFS
> file with manually written read callback function.

With below nit addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/spi/spi-dw.c | 86 ++++++++++++++------------------------------
>  drivers/spi/spi-dw.h |  2 ++
>  2 files changed, 28 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 31607b40147d..bb470cff40d3 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -29,66 +29,29 @@ struct chip_data {
>  };
>  
>  #ifdef CONFIG_DEBUG_FS
> -#define SPI_REGS_BUFSIZE	1024
> -static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
> -		size_t count, loff_t *ppos)
> -{
> -	struct dw_spi *dws = file->private_data;
> -	char *buf;
> -	u32 len = 0;
> -	ssize_t ret;
> -
> -	buf = kzalloc(SPI_REGS_BUFSIZE, GFP_KERNEL);
> -	if (!buf)
> -		return 0;
> -
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"%s registers:\n", dev_name(&dws->master->dev));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"=================================\n");
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"CTRLR0: \t0x%08x\n", dw_readl(dws, DW_SPI_CTRLR0));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"CTRLR1: \t0x%08x\n", dw_readl(dws, DW_SPI_CTRLR1));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"SSIENR: \t0x%08x\n", dw_readl(dws, DW_SPI_SSIENR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"SER: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SER));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"BAUDR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_BAUDR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFTLR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFTLR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"TXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_TXFLR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"RXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_RXFLR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"SR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"IMR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_IMR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"ISR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_ISR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"DMACR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_DMACR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"=================================\n");
> -
> -	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
> -	kfree(buf);
> -	return ret;
> +
> +#define DW_SPI_DBGFS_REG(_name, _off)	\
> +{					\
> +	.name = _name,			\

> +	.offset = _off			\

As previously discussed (did I miss your answer?) the comma at the end leaves
better pattern for maintenance prospective.

>  }
>  
> -static const struct file_operations dw_spi_regs_ops = {
> -	.owner		= THIS_MODULE,
> -	.open		= simple_open,
> -	.read		= dw_spi_show_regs,
> -	.llseek		= default_llseek,
> +static const struct debugfs_reg32 dw_spi_dbgfs_regs[] = {
> +	DW_SPI_DBGFS_REG("CTRLR0", DW_SPI_CTRLR0),
> +	DW_SPI_DBGFS_REG("CTRLR1", DW_SPI_CTRLR1),
> +	DW_SPI_DBGFS_REG("SSIENR", DW_SPI_SSIENR),
> +	DW_SPI_DBGFS_REG("SER", DW_SPI_SER),
> +	DW_SPI_DBGFS_REG("BAUDR", DW_SPI_BAUDR),
> +	DW_SPI_DBGFS_REG("TXFTLR", DW_SPI_TXFTLR),
> +	DW_SPI_DBGFS_REG("RXFTLR", DW_SPI_RXFTLR),
> +	DW_SPI_DBGFS_REG("TXFLR", DW_SPI_TXFLR),
> +	DW_SPI_DBGFS_REG("RXFLR", DW_SPI_RXFLR),
> +	DW_SPI_DBGFS_REG("SR", DW_SPI_SR),
> +	DW_SPI_DBGFS_REG("IMR", DW_SPI_IMR),
> +	DW_SPI_DBGFS_REG("ISR", DW_SPI_ISR),
> +	DW_SPI_DBGFS_REG("DMACR", DW_SPI_DMACR),
> +	DW_SPI_DBGFS_REG("DMATDLR", DW_SPI_DMATDLR),
> +	DW_SPI_DBGFS_REG("DMARDLR", DW_SPI_DMARDLR)
>  };
>  
>  static int dw_spi_debugfs_init(struct dw_spi *dws)
> @@ -100,8 +63,11 @@ static int dw_spi_debugfs_init(struct dw_spi *dws)
>  	if (!dws->debugfs)
>  		return -ENOMEM;
>  
> -	debugfs_create_file("registers", S_IFREG | S_IRUGO,
> -		dws->debugfs, (void *)dws, &dw_spi_regs_ops);
> +	dws->regset.regs = dw_spi_dbgfs_regs;
> +	dws->regset.nregs = ARRAY_SIZE(dw_spi_dbgfs_regs);
> +	dws->regset.base = dws->regs;
> +	debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 24462b0c65cb..4adce6da6013 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -2,6 +2,7 @@
>  #ifndef DW_SPI_HEADER_H
>  #define DW_SPI_HEADER_H
>  
> +#include <linux/debugfs.h>
>  #include <linux/irqreturn.h>
>  #include <linux/io.h>
>  #include <linux/scatterlist.h>
> @@ -150,6 +151,7 @@ struct dw_spi {
>  
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;
> +	struct debugfs_regset32 regset;
>  #endif
>  };
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


