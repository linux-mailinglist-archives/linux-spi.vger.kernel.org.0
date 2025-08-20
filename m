Return-Path: <linux-spi+bounces-9566-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E39B2DFAD
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BDD1BC42DC
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAB27145F;
	Wed, 20 Aug 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQUraHoN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3C2874E1;
	Wed, 20 Aug 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700806; cv=none; b=RHCD4dis7azAjWd2o6Fz/9TDbb6Kqb7pmk9p9FBT+5JqKwQMK6EpJKlIVnW5lQM5p+deQAqeirHWrv8mHGKJ2Taxk0qW9qqhi8g7X5Ad1xveUpx4VaVwwQLFFkS/V6porpSR7aHv5xWgQ6sWTHIMcf26yEZYWZGE/a9YdIC0SCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700806; c=relaxed/simple;
	bh=2hsnr/uRVQ+w7TjHXO9WA8NgE8Si4u9KkJy0PnQOYm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW25CI6rq5uEvUK4fLUhQP4sSAS4Zxty53CgVnInX7+JuRzDQHbuacsfENSKK9AX8NK2WEgve9sMWcVCdOaeOy0e0cjNI1ZEPaI5N/UgnA7sip6RuCDi/hVDReUtsCK8IMzGqDf+teIhqRmuc1fhW8t45QeGigwf244HdWsm6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQUraHoN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755700804; x=1787236804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hsnr/uRVQ+w7TjHXO9WA8NgE8Si4u9KkJy0PnQOYm0=;
  b=YQUraHoNHlujSEUc8EB1vMBwM46z3GRGmYodLb44TZZ6jSKgEG4NQVk/
   /ACVBBlZ6Exy23umh09MNWnVOIf9xZ4n3NF4V4Rgd60kob9nYfrrBEeBr
   JbUv48UhgyhGWM3bYA69ICRDIVtIZ9CPCM3YRTMtLc4Lz9sbhMExvpZGB
   cXr8XGEimeABIxPNK8yNF6lcgug/Cwi3uaJl0lMaTLXbnJfMvKw+Q+V8f
   QVYI4qeZ4Sk1zka18mtkR9RZpEUJCfzvxF8XDrN/2toIoQxeVzQ7tIFJL
   A7fNMRxBP83miuHtRT/8skKT2RJDUJf/qq4uQ1SYhyD2LoE5KMmo31qcG
   g==;
X-CSE-ConnectionGUID: gVQW9O1YSK6JP1IpuS027Q==
X-CSE-MsgGUID: c+dzXP14SOGjWiCHjFaFoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69066266"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69066266"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:40:03 -0700
X-CSE-ConnectionGUID: NhCdyxuzQKa/uXKfQLMGCA==
X-CSE-MsgGUID: t5SSJQBWQkWyVxtyIDNJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173494971"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:40:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojyn-00000006xan-3C2o;
	Wed, 20 Aug 2025 17:39:57 +0300
Date: Wed, 20 Aug 2025 17:39:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com
Subject: Re: [PATCH v4 3/3] SPI: Add virtio SPI driver
Message-ID: <aKXePVShWzXGi8yP@smile.fi.intel.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-4-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820084944.84505-4-quic_haixcui@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 04:49:44PM +0800, Haixu Cui wrote:
> This is the virtio SPI Linux kernel driver.

...

> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_spi.h>

> +#define VIRTIO_SPI_MODE_MASK \
> +	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)

We have SPI_MODE_X_MASK.

...

> +struct virtio_spi_req {
> +	struct completion completion;
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const u8 *tx_buf;
> +	u8 *rx_buf;
> +	struct spi_transfer_result result	____cacheline_aligned;
> +};

Dunno if `pahole` aware of ____cacheline_aligned attribute, but does it shows
any potential improvement?

I think the fields can be reshuffled to go last and only one needs that
attribute.

struct virtio_spi_req {
	struct completion completion;
	const u8 *tx_buf;
	u8 *rx_buf;
	struct spi_transfer_head transfer_head	____cacheline_aligned;
	struct spi_transfer_result result;
};

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

Hmm... Not a problem in your code, but ns can be quite high for low speed
links, there is a potential overflow...

> +		dev_warn(&spi->dev, "Cannot convert cs_setup\n");
> +		return cs_setup;
> +	}
> +	th->cs_setup_ns = cpu_to_le32(cs_setup);
> +
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

> +	if (cs_word_delay_spi > cs_word_delay_xfer)
> +		th->word_delay_ns = cpu_to_le32(cs_word_delay_spi);
> +	else
> +		th->word_delay_ns = cpu_to_le32(cs_word_delay_xfer);

Why not max() ?

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
> +	struct virtio_spi_req *spi_req;
> +	struct spi_transfer_head *th;
> +	struct scatterlist sg_out_head, sg_out_payload;
> +	struct scatterlist sg_in_result, sg_in_payload;
> +	struct scatterlist *sgs[4];

> +	unsigned int outcnt = 0u;
> +	unsigned int incnt = 0u;

Are 'u':s important in this case/

> +	int ret;
> +
> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> +	if (!spi_req)
> +		return -ENOMEM;
> +
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

> +	kfree(spi_req);

Can be called via __free() to simplify the error handling,

> +	if (ret)
> +		ctrl->cur_msg->status = ret;
> +
> +	return ret;
> +}

...

> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;

> +	int err;

Out of a sudden it's named 'err'. Please, go through the code and make
style/naming/etc consistent.

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

> +	/* Setup ACPI node for controlled devices which will be probed through ACPI. */
> +	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));

This is strange. Either you need to put parent above in device_set_node() or
drop it here. Otherwise it's inconsistent. Needs a very good explanation what's
going on here...

> +	dev_set_drvdata(&vdev->dev, ctrl);
> +
> +	err = device_property_read_u32(&vdev->dev, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)

This is wrong. What is the bus_num value when err != 0?
And why do we even care about this?

> +		ctrl->bus_num = bus_num;
> +	else
> +		ctrl->bus_num = -1;
> +
> +	virtio_spi_read_config(vdev);
> +
> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {

> +		dev_err_probe(&vdev->dev, err, "Cannot setup virtqueues\n");
> +		return err;

		return dev_err_probe(...);

> +	}

> +	/* Register cleanup for virtqueues using devm */
> +	err = devm_add_action_or_reset(&vdev->dev, (void (*)(void *))virtio_spi_del_vq, vdev);
> +	if (err) {
> +		dev_err_probe(&vdev->dev, err, "Cannot register virtqueue cleanup\n");
> +		return err;
> +	}
> +
> +	/* Use devm version to register controller */
> +	err = devm_spi_register_controller(&vdev->dev, ctrl);
> +	if (err) {
> +		dev_err_probe(&vdev->dev, err, "Cannot register controller\n");
> +		return err;

As per above.

> +	}
> +
> +	return 0;
> +}

...

> +static int virtio_spi_freeze(struct device *dev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
> +	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);

Use dev_to_virtio()

> +	int ret;
> +
> +	ret = spi_controller_suspend(ctrl);
> +	if (ret) {
> +		dev_warn(dev, "cannot suspend controller (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	virtio_spi_del_vq(vdev);
> +	return 0;
> +}
> +
> +static int virtio_spi_restore(struct device *dev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
> +	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);

As per above.

> +	int ret;
> +
> +	ret = virtio_spi_find_vqs(vdev->priv);
> +	if (ret) {
> +		dev_err(dev, "problem starting vqueue (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = spi_controller_resume(ctrl);
> +	if (ret)
> +		dev_err(dev, "problem resuming controller (%d)\n", ret);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



