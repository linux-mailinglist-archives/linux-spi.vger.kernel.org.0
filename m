Return-Path: <linux-spi+bounces-9835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8AEB3E239
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 14:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232D53BF3EE
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CFF261B93;
	Mon,  1 Sep 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klJz7aX5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94425EFBF;
	Mon,  1 Sep 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728429; cv=none; b=bhtAwNs6uJJWOagMybPY841WE6diRCRSkyQUaa0JqciqpLyLGW6p+TYyeyO5OokGTGyo0K0GBokZOuB+DJqNmYuuuAD4BEAETTZrxj6pj/Qfb5UeAyBVp+CZfPfF8EqFovgXIJM/mGk7h4iDoDGedmkBEZwH5xDqGELv1KLBEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728429; c=relaxed/simple;
	bh=NnnVmDOEYrbdmnujn4Lul2TG+QyYkE2QL0d/N5DPfSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POJFej5mUiGzaTDN7yXLPfv5ZV+gDh2iMVHC9oAaQpvUQM8Bx8PV1SkKcwEqmo0MsSlA7gvDu5+hz18cz6u2m1YaSXF9lTyrL9pD3WZVORwToxXqfDlQwhBR7RMHD2qeM6uN2qxo7GdnISzPjGxxbPWklywUrIqOFX+eNEr83dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klJz7aX5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756728427; x=1788264427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NnnVmDOEYrbdmnujn4Lul2TG+QyYkE2QL0d/N5DPfSw=;
  b=klJz7aX5pTvcIX9ZfcW7zfrn1ceiLNnbsVgp+n2vIaPzE8giVIaEOOaw
   UF/4PC5cC7yacbkJAjEV5Q9K5GvGSo+z0+AMt7ZC2llubjx0H45VoYwT5
   AiRt+GwlBGeSqrkh+Krhfv6YDu2fG+7KWt0s2xx93rTggQV+O8jW56LAd
   gHmOKoPCU6rkFEv5ks7onjDbrPbYTsetgcWVajpwTqX4UEPxuzvCsakdF
   mF6pu8ehXdO4n12EnK9IW6H3IgvavaXmvR7IdtdtJNRFm2fPk8YJPw8Va
   A1or8KBNA3+Ar8Vsk1MX9kV+iGvAlKVagixclxChKcteXTMzPD/O/xKGc
   g==;
X-CSE-ConnectionGUID: 5k3ZKtxcSoO4sgbIpkOBFg==
X-CSE-MsgGUID: qv6GAFcRQK+NEYm3AZbjrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="76433054"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="76433054"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:07:07 -0700
X-CSE-ConnectionGUID: FTm+C/DoTSCAJrkzgjTPkQ==
X-CSE-MsgGUID: UJA0ZIAkSLyy6Wv9SAaDdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175380316"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:07:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ut3JN-0000000APIW-105E;
	Mon, 01 Sep 2025 15:07:01 +0300
Date: Mon, 1 Sep 2025 15:07:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
Message-ID: <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828093451.2401448-4-quic_haixcui@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
> This is the virtio SPI Linux kernel driver.

...

> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>

A lot of headers are still missing. See below.

...


> +struct virtio_spi_priv {
> +	/* The virtio device we're associated with */
> +	struct virtio_device *vdev;
> +	/* Pointer to the virtqueue */
> +	struct virtqueue *vq;
> +	/* Copy of config space mode_func_supported */
> +	u32 mode_func_supported;

uXX (in particular u32) is defined in types.h.

> +	/* Copy of config space max_freq_hz */
> +	u32 max_freq_hz;
> +};

...

> +static int virtio_spi_set_delays(struct spi_transfer_head *th,
> +				 struct spi_device *spi,
> +				 struct spi_transfer *xfer)
> +{
> +	int cs_setup;
> +	int cs_word_delay_xfer;
> +	int cs_word_delay_spi;
> +	int delay;
> +	int cs_hold;
> +	int cs_inactive;
> +	int cs_change_delay;
> +
> +	cs_setup = spi_delay_to_ns(&spi->cs_setup, xfer);
> +	if (cs_setup < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_setup\n");

dev_warn() et al. are defined in dev_printk.h.

> +		return cs_setup;
> +	}
> +	th->cs_setup_ns = cpu_to_le32(cs_setup);

This requires

#include <asm/byteorder.h>

> +	cs_word_delay_xfer = spi_delay_to_ns(&xfer->word_delay, xfer);
> +	if (cs_word_delay_xfer < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_word_delay_xfer\n");
> +		return cs_word_delay_xfer;
> +	}
> +	cs_word_delay_spi = spi_delay_to_ns(&spi->word_delay, xfer);
> +	if (cs_word_delay_spi < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_word_delay_spi\n");
> +		return cs_word_delay_spi;
> +	}
> +
> +	th->word_delay_ns = cpu_to_le32(max(cs_word_delay_spi, cs_word_delay_xfer));

max() is defined in math.h.

> +	delay = spi_delay_to_ns(&xfer->delay, xfer);
> +	if (delay < 0) {
> +		dev_warn(&spi->dev, "Cannot convert delay\n");
> +		return delay;
> +	}
> +	cs_hold = spi_delay_to_ns(&spi->cs_hold, xfer);
> +	if (cs_hold < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_hold\n");
> +		return cs_hold;
> +	}
> +	th->cs_delay_hold_ns = cpu_to_le32(delay + cs_hold);
> +
> +	cs_inactive = spi_delay_to_ns(&spi->cs_inactive, xfer);
> +	if (cs_inactive < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_inactive\n");
> +		return cs_inactive;
> +	}
> +	cs_change_delay = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
> +	if (cs_change_delay < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_change_delay\n");
> +		return cs_change_delay;
> +	}
> +	th->cs_change_delay_inactive_ns =
> +		cpu_to_le32(cs_inactive + cs_change_delay);
> +
> +	return 0;
> +}

...

> +static int virtio_spi_transfer_one(struct spi_controller *ctrl,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *xfer)
> +{
> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);

> +	struct virtio_spi_req *spi_req __free(kfree);

This is incorrect template. It's one of the exceptions when we mix code and
definitions...

> +	struct spi_transfer_head *th;
> +	struct scatterlist sg_out_head, sg_out_payload;
> +	struct scatterlist sg_in_result, sg_in_payload;

+ scatterlist.h

> +	struct scatterlist *sgs[4];
> +	unsigned int outcnt = 0;
> +	unsigned int incnt = 0;
> +	int ret;


> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);

...so this should be

	struct virtio_spi_req *spi_req __free(kfree) =
		kzalloc(sizeof(*spi_req), GFP_KERNEL);

(or on one line if you are okay with a 100 limit).

And do not forget to include cleanup.h (__free() macro) and
slab.h (kzalloc() API).

> +	if (!spi_req)
> +		return -ENOMEM;

+ errno.h

But since you already have IS_ERR()/PTR_ERR() use, just

+ err.h

> +	init_completion(&spi_req->completion);
> +
> +	th = &spi_req->transfer_head;
> +
> +	/* Fill struct spi_transfer_head */
> +	th->chip_select_id = spi_get_chipselect(spi, 0);
> +	th->bits_per_word = spi->bits_per_word;
> +	th->cs_change = xfer->cs_change;
> +	th->tx_nbits = xfer->tx_nbits;
> +	th->rx_nbits = xfer->rx_nbits;
> +	th->reserved[0] = 0;
> +	th->reserved[1] = 0;
> +	th->reserved[2] = 0;
> +
> +	static_assert(VIRTIO_SPI_CPHA == SPI_CPHA,
> +		      "VIRTIO_SPI_CPHA must match SPI_CPHA");
> +	static_assert(VIRTIO_SPI_CPOL == SPI_CPOL,
> +		      "VIRTIO_SPI_CPOL must match SPI_CPOL");
> +	static_assert(VIRTIO_SPI_CS_HIGH == SPI_CS_HIGH,
> +		      "VIRTIO_SPI_CS_HIGH must match SPI_CS_HIGH");
> +	static_assert(VIRTIO_SPI_MODE_LSB_FIRST == SPI_LSB_FIRST,
> +		      "VIRTIO_SPI_MODE_LSB_FIRST must match SPI_LSB_FIRST");
> +
> +	th->mode = cpu_to_le32(spi->mode & VIRTIO_SPI_MODE_MASK);
> +	if (spi->mode & SPI_LOOP)
> +		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
> +
> +	th->freq = cpu_to_le32(xfer->speed_hz);
> +
> +	ret = virtio_spi_set_delays(th, spi, xfer);
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Set buffers */
> +	spi_req->tx_buf = xfer->tx_buf;
> +	spi_req->rx_buf = xfer->rx_buf;
> +
> +	/* Prepare sending of virtio message */
> +	init_completion(&spi_req->completion);
> +
> +	sg_init_one(&sg_out_head, th, sizeof(*th));
> +	sgs[outcnt] = &sg_out_head;
> +	outcnt++;
> +
> +	if (spi_req->tx_buf) {
> +		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
> +		sgs[outcnt] = &sg_out_payload;
> +		outcnt++;
> +	}
> +
> +	if (spi_req->rx_buf) {
> +		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
> +		sgs[outcnt] = &sg_in_payload;
> +		incnt++;
> +	}
> +
> +	sg_init_one(&sg_in_result, &spi_req->result,
> +		    sizeof(struct spi_transfer_result));
> +	sgs[outcnt + incnt] = &sg_in_result;
> +	incnt++;
> +
> +	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
> +				GFP_KERNEL);
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Simple implementation: There can be only one transfer in flight */
> +	virtqueue_kick(priv->vq);
> +
> +	wait_for_completion(&spi_req->completion);
> +
> +	/* Read result from message and translate return code */
> +	switch (spi_req->result.result) {
> +	case VIRTIO_SPI_TRANS_OK:
> +		break;
> +	case VIRTIO_SPI_PARAM_ERR:
> +		ret = -EINVAL;
> +		break;
> +	case VIRTIO_SPI_TRANS_ERR:
> +		ret = -EIO;
> +		break;
> +	default:
> +		ret = -EIO;
> +		break;
> +	}
> +
> +msg_done:
> +	if (ret)
> +		ctrl->cur_msg->status = ret;
> +
> +	return ret;
> +}

...

> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
> +{
> +	struct virtqueue *vq;
> +
> +	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
> +	if (IS_ERR(vq))
> +		return PTR_ERR(vq);

See above.

> +	priv->vq = vq;
> +	return 0;
> +}

...

> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;
> +	int ret;
> +	u32 bus_num;
> +
> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;

> +	device_set_node(&ctrl->dev, dev_fwnode(&vdev->dev));
> +	dev_set_drvdata(&vdev->dev, ctrl);
> +	ret = device_property_read_u32(&vdev->dev, "spi,bus-num", &bus_num);

+ device.h
+ property.h

> +	if (ret || bus_num > S16_MAX)

+ limits.h

> +		ctrl->bus_num = -1;
> +	else
> +		ctrl->bus_num = bus_num;

But why do we need this property at all? And where is it documented in the
device tree bindings?

> +	virtio_spi_read_config(vdev);
> +
> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	ret = virtio_spi_find_vqs(priv);
> +	if (ret)
> +		return dev_err_probe(&vdev->dev, ret, "Cannot setup virtqueues\n");
> +
> +	/* Register cleanup for virtqueues using devm */
> +	ret = devm_add_action_or_reset(&vdev->dev, virtio_spi_del_vq, vdev);
> +	if (ret)
> +		return dev_err_probe(&vdev->dev, ret, "Cannot register virtqueue cleanup\n");
> +
> +	/* Use devm version to register controller */
> +	ret = devm_spi_register_controller(&vdev->dev, ctrl);
> +	if (ret)
> +		return dev_err_probe(&vdev->dev, ret, "Cannot register controller\n");
> +
> +	return 0;
> +}

...

> +static struct virtio_device_id virtio_spi_id_table[] = {

The type is or should be defined in mod_devicetable.h.

> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
> +	{}
> +};

...

> +static const struct dev_pm_ops virtio_spi_pm_ops = {

The type is defined in pm.h.

> +	.freeze = pm_sleep_ptr(virtio_spi_freeze),
> +	.restore = pm_sleep_ptr(virtio_spi_restore),
> +};


-- 
With Best Regards,
Andy Shevchenko



