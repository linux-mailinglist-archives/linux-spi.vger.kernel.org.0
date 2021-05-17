Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19176382589
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEQHnO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 03:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhEQHnM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 03:43:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E6FC06175F;
        Mon, 17 May 2021 00:41:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A2C521F41C79;
        Mon, 17 May 2021 08:41:44 +0100 (BST)
Date:   Mon, 17 May 2021 09:41:40 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v2 1/3] spi: spi-mem: add automatic poll status
 functions
Message-ID: <20210517094140.53cb643a@collabora.com>
In-Reply-To: <20210507131756.17028-2-patrice.chotard@foss.st.com>
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
        <20210507131756.17028-2-patrice.chotard@foss.st.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 7 May 2021 15:17:54 +0200
<patrice.chotard@foss.st.com> wrote:

> +/**
> + * spi_mem_poll_status() - Poll memory device status
> + * @mem: SPI memory device
> + * @op: the memory operation to execute
> + * @mask: status bitmask to ckeck
> + * @match: (status & mask) expected value
> + * @timeout_ms: timeout in milliseconds
> + *
> + * This function send a polling status request to the controller driver
> + *
> + * Return: 0 in case of success, -ETIMEDOUT in case of error,
> + *         -EOPNOTSUPP if not supported.
> + */
> +int spi_mem_poll_status(struct spi_mem *mem,
> +			const struct spi_mem_op *op,
> +			u16 mask, u16 match, u16 timeout_ms)

Maybe you should pass a delay_us too, to poll the status at the right
rate in the SW-based case (can also be used by drivers if they need to
configure the polling rate). You could also add an initial_delay_us to
avoid polling the status too early: an erase operation will take longer
than a write which will take longer than a read. No need to check the
status just after issuing the command, especially if the polling is
done in SW. Those 2 arguments should also be passed to the driver.

> +{
> +	struct spi_controller *ctlr = mem->spi->controller;
> +	unsigned long ms;
> +	int ret = -EOPNOTSUPP;
> +	int exec_op_ret;
> +	u16 *status;
> +
> +	if (!spi_mem_supports_op(mem, op))
> +		return ret;
> +
> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
> +		ret = spi_mem_access_start(mem);
> +		if (ret)
> +			return ret;
> +
> +		reinit_completion(&ctlr->xfer_completion);
> +
> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
> +						 timeout_ms);
> +
> +		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> +						 msecs_to_jiffies(timeout_ms));
> +
> +		spi_mem_access_end(mem);
> +		if (!ms)
> +			return -ETIMEDOUT;
> +	} else {
> +		status = (u16 *)op->data.buf.in;
> +		ret = read_poll_timeout(spi_mem_exec_op, exec_op_ret,
> +					((*status) & mask) == match, 20,
> +					timeout_ms * 1000, false, mem, op);
> +		if (exec_op_ret)
> +			return exec_op_ret;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_poll_status);
> +
