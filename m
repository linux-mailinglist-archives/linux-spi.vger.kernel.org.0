Return-Path: <linux-spi+bounces-9343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB1B20B78
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 16:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E9519014B3
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B9211A19;
	Mon, 11 Aug 2025 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNe8zycw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BD1DC9B8;
	Mon, 11 Aug 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921547; cv=none; b=uF9M0tg7OQ3t1b8FX5JIN9h0Das64OiZrilWtthiizLBhjflsYlIBBJlrVB9Eyfuj4Z50t/FLiX3oVUm6BHpMLiF5vZdwteDqGg/XT7T3O0YJle6sRH0pa8hxq6zu4INgRXFlbKbx1O0wE57Y6TnquKxGL8Na5jdO1I2TuT2YTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921547; c=relaxed/simple;
	bh=ebmSgAS2CMFkto6/WZb72Q3to9S6Hc9yLPFeDAuubdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUfIMnUiPGAPyeUr2pEndxokHuYYxXC93EUDF+G6bYI1CyCM/s83WISp8Uf6zd2rigJNU027YRXYknhU6iGAB+oIeYJ+aVcqRKOFDggQ0ymeMRDkufHOmjww8dzKTrBBMgzyZle1Gn+Y7uBBj0oVljeQm3xSbrmy2K09jRwiXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNe8zycw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754921544; x=1786457544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ebmSgAS2CMFkto6/WZb72Q3to9S6Hc9yLPFeDAuubdg=;
  b=QNe8zycwsx2QqSX3w/lMalB0M/jr7C7Y5XO/c6tJtFWYO6hwCQXqWrTF
   u7Hh4X5aIj/2or/TATFuaJjbaN94XTBTGwwapMIP29AkVeN/5z64I7mcr
   LVeehxenzGRMEuZ8G1c1IK7qZvZWMuQGIagUY52hwiMGaQbWrPH8+6krZ
   sUB4HMqYQQhiah2/YOJXkyWqU5Pp7gCwiphVQdYXB0azKSEmA0d+FEN1X
   BzMook/lLg/xmDNDVTDk84zw4o3NHRo0K7ij643Ygg/KLV5yxgAX1PfWk
   3sQcyIL67empXBCC5FJwweqzR9SgzKGzE8ciMlN+0jgGXD9vrwoGUnqnJ
   g==;
X-CSE-ConnectionGUID: LFiIa9hrSZK7NDW3weqUmw==
X-CSE-MsgGUID: glPXBE+XTc673O8dmJ5lzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="82615180"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="82615180"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 07:12:23 -0700
X-CSE-ConnectionGUID: PnGsZ9HfQumUGlGt6UUeGQ==
X-CSE-MsgGUID: txZKqF/USt+SXVZlH0gemQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166723733"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 11 Aug 2025 07:12:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F3F5B94; Mon, 11 Aug 2025 16:12:19 +0200 (CEST)
Date: Mon, 11 Aug 2025 16:12:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: broonie@kernel.org, virtio-dev@lists.oasis-open.org,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com
Subject: Re: [RFC PATCH v4 3/3] SPI: Add virtio SPI driver
Message-ID: <aJn6Q3oPX3RyG22L@black.igk.intel.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-4-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401033621.1614194-4-quic_haixcui@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 01, 2025 at 11:36:21AM +0800, Haixu Cui wrote:

...

> +VIRTIO SPI DRIVER
> +M:	Haixu Cui <quic_haixcui@quicinc.com>
> +S:	Maintained
> +F:	drivers/spi/spi-virtio.c
> +F:	include/uapi/linux/virtio_spi.h

This should have been started by the very first patch that brings a new file
into the kernel. Here I would expect only one line (file) being added. Have you
run checkpatch?

...

> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>

> +#include <linux/kernel.h>

Please, no. Try to follow IWYU principle.

> +#include <linux/module.h>

> +#include <linux/of.h>

Why? AFAIK we may avoid this in the new code. If even needed, there are device
property APIs and software nodes. But I believe the inclusions in this driver is
just a cargo cult, as I said follow Include What You Use principle.

> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_spi.h>

...

> +struct virtio_spi_req {
> +	struct completion completion;
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const uint8_t *tx_buf			____cacheline_aligned;

Why ____cacheline_aligned for the *pointer*?

> +	uint8_t *rx_buf				____cacheline_aligned;

Ditto.

> +	struct spi_transfer_result result	____cacheline_aligned;
> +};

...

> +	if (cs_word_delay_spi > cs_word_delay_xfer)
> +		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_spi);
> +	else
> +		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_xfer);

Why explicit casting? What is the purpose? Same for other cases.

...

> +	BUILD_BUG_ON(VIRTIO_SPI_CPHA != SPI_CPHA);
> +	BUILD_BUG_ON(VIRTIO_SPI_CPOL != SPI_CPOL);
> +	BUILD_BUG_ON(VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH);
> +	BUILD_BUG_ON(VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST);

Make this to be static_assert():s as they give better error message.

...

> +	th->mode = cpu_to_le32(spi->mode & (SPI_LSB_FIRST | SPI_CS_HIGH |
> +					    SPI_CPOL | SPI_CPHA));

We have _MODE_MASK, use it.

...

> +	if ((spi->mode & SPI_LOOP) != 0)

' != 0' is redundant.

> +		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);

...

> +	/* Read result from message and translate return code */
> +	switch (priv->spi_req.result.result) {
> +	case VIRTIO_SPI_TRANS_OK:
> +		/* ret is 0 */

Why comment? Make it to be a code statement which also makes code robust to
subtle changes.

> +		break;
> +	case VIRTIO_SPI_PARAM_ERR:
> +		ret = -EINVAL;
> +		break;
> +	case VIRTIO_SPI_TRANS_ERR:
> +		ret = -EIO;
> +		break;
> +	default: /* Protocol violation */
> +		ret = -EIO;
> +		break;
> +	}

...

> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1) != 0)
> +		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1) != 0)
> +		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST) != 0)
> +		ctrl->mode_bits |= SPI_LSB_FIRST;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK) != 0)
> +		ctrl->mode_bits |= SPI_LOOP;

> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
> +		ctrl->mode_bits |= SPI_TX_DUAL;
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
> +		ctrl->mode_bits |= SPI_TX_QUAD;
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
> +		ctrl->mode_bits |= SPI_TX_OCTAL;

> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
> +		ctrl->mode_bits |= SPI_RX_DUAL;
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
> +		ctrl->mode_bits |= SPI_RX_QUAD;
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
> +		ctrl->mode_bits |= SPI_RX_OCTAL;

' != 0' is redundant in all of the above.

...

> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
> +{
> +	struct virtqueue *vq;
> +
> +	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
> +	if (IS_ERR(vq))
> +		return (int)PTR_ERR(vq);

Why casting?

> +	priv->vq = vq;
> +	return 0;
> +}

...

> +	ctrl->dev.of_node = vdev->dev.of_node;
> +
> +	/*
> +	 * Setup ACPI node for controlled devices which will be probed through
> +	 * ACPI.
> +	 */
> +	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));

	device_set_node();

(it might require to use dev_fwnode() from property.h)

...

> +	err = device_property_read_u32(&ctrl->dev, "spi,bus-num", &bus_num);

Despite above, use &vdev->dev to read properties as this makes code clearer in
aspect of the device that provides the properties to begin with.

> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;

Why casting?

> +	else
> +		ctrl->bus_num = -1;

...

> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +
> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */
> +	spi_unregister_controller(ctrl);
> +	virtio_spi_del_vq(vdev);

Wrap this to devm and drop the remove() completely.

> +}

...

> +static struct virtio_device_id virtio_spi_id_table[] = {
> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
> +	{ 0 },

Remove trailing comma (it's a terminator) and also unneeded 0.

> +};
> +
> +static struct virtio_driver virtio_spi_driver = {

> +	.driver.name = KBUILD_MODNAME,

Use standard pattern

	.driver = {
		.name = ...
	},

> +	.driver.owner = THIS_MODULE,

This field is set by module_virtio_driver(), isn't it?

> +	.id_table = virtio_spi_id_table,
> +	.probe = virtio_spi_probe,
> +	.remove = virtio_spi_remove,

> +	.freeze = pm_sleep_ptr(virtio_spi_freeze),
> +	.restore = pm_sleep_ptr(virtio_spi_restore),

Why are these not a dev_pm_ops?

> +};

> +

Redundant blank line, remove.

> +module_virtio_driver(virtio_spi_driver);

> +MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);

Move this up to follow up the ID table initializer.

-- 
With Best Regards,
Andy Shevchenko



