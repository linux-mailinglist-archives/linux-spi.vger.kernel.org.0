Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB18C1CB84F
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHTac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:30:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:16158 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTab (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:30:31 -0400
IronPort-SDR: fQJ/emE8C9GFfCH+1X9WM1oqYreCqYO+tdoWMMH6nIMCbXv7eqU4xRVcbNwtdncnlOpfQgoyGM
 YEZ8POg+szkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:30:30 -0700
IronPort-SDR: qUJg5FWE9T6yxRJd6UrC8vXGxIwhzVM/K7NWb+omN3LD3c/t1BhxRug8l7kdPlUb3zgtwW3ZFY
 nMLL0PlKEcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="249842809"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2020 12:30:25 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8hX-005T9Y-3I; Fri, 08 May 2020 22:30:27 +0300
Date:   Fri, 8 May 2020 22:30:27 +0300
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
        devicetree@vger.kernel.org, fengsheng <fengsheng5@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Aditya Pakki <pakki001@umn.edu>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] spi: dw: Use regset32 DebugFS method to create a
 registers file
Message-ID: <20200508193027.GW185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-18-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:42PM +0300, Serge Semin wrote:
> DebugFS kernel interface provides a dedicated method to create the
> registers dump file. Use it instead of creating a generic DebugFS
> file with manually written read callback function.

Of course ideal would be use something like regmap API which delivers this as a side effect.
But this also good clean up!
Comments below.

> 
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
>  drivers/spi/spi-dw.c | 85 +++++++++++++-------------------------------
>  drivers/spi/spi-dw.h |  2 ++
>  2 files changed, 27 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 897c998af578..625a5f152e1a 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -32,66 +32,28 @@ struct chip_data {
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
> -			"CTRL0: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL0));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"CTRL1: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL1));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"SSIENR: \t0x%08x\n", dw_readl(dws, DW_SPI_SSIENR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"SER: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SER));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"BAUDR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_BAUDR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFLTR));
> -	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> -			"RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFLTR));
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
> +#define DW_SPI_DBGFS_REG(_name, _off)	\
> +{					\
> +	.name = _name,			\
> +	.offset = _off			\

Leave comma here.

>  }
>  
> -static const struct file_operations dw_spi_regs_ops = {
> -	.owner		= THIS_MODULE,
> -	.open		= simple_open,
> -	.read		= dw_spi_show_regs,
> -	.llseek		= default_llseek,
> +static const struct debugfs_reg32 dw_spi_dbgfs_regs[] = {
> +	DW_SPI_DBGFS_REG("CTRL0", DW_SPI_CTRL0),
> +	DW_SPI_DBGFS_REG("CTRL1", DW_SPI_CTRL1),
> +	DW_SPI_DBGFS_REG("SSIENR", DW_SPI_SSIENR),
> +	DW_SPI_DBGFS_REG("SER", DW_SPI_SER),
> +	DW_SPI_DBGFS_REG("BAUDR", DW_SPI_BAUDR),
> +	DW_SPI_DBGFS_REG("TXFTLR", DW_SPI_TXFLTR),
> +	DW_SPI_DBGFS_REG("RXFTLR", DW_SPI_RXFLTR),
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
> @@ -103,8 +65,11 @@ static int dw_spi_debugfs_init(struct dw_spi *dws)
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
> index a6c03ea9013c..bad0eca2efe6 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/io.h>
>  #include <linux/scatterlist.h>
> +#include <linux/debugfs.h>

Perhaps keep ordered?

>  
>  /* Register offsets */
>  #define DW_SPI_CTRL0			0x00
> @@ -142,6 +143,7 @@ struct dw_spi {
>  	void			*priv;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;

> +	struct debugfs_regset32 regset;

I'm wondering why we need it here and not simple on the stack?

>  #endif
>  };
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


