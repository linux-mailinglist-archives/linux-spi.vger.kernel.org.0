Return-Path: <linux-spi+bounces-6148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC69FAB43
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 08:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CBC1885526
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB9189520;
	Mon, 23 Dec 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtHZwfsU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74C13F43A;
	Mon, 23 Dec 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939961; cv=none; b=nfUBhYmVxPDbvqUeZGTa+BMOR/AQPk+GRSDaDizE4Nkb9HKfiJbYxa+oVj2R/T9mwjVOIHAzcxh+qLSpvS9ZeLXo0sDjpnnIIz4bB4V76P2aWYzKftzujW8PWLEGjG6J3RVgH4Zch1PdG5Z4s1PW3hSaDhNBPkeoT+Z2KCOlX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939961; c=relaxed/simple;
	bh=IicggW/j3FuuHrkwuIJ0qGLGDAUfsPsZ73p9zFdyAjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfblkGk6Mp4Dv9QPDKCstRtbUjeVQnFqmraMA+xtLpFh8Bl+pQDSV44YTKBCRMoPAKA0blOFGFvsm/VkQQSRmCXee1ZcJbutpne0ystu9ROmrhTOeO+8UXMkAM1ZpUm3XxhxWNF0YHSvuDH6X+utV4wJNh0ap6E6I0LkN+sy6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtHZwfsU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734939960; x=1766475960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IicggW/j3FuuHrkwuIJ0qGLGDAUfsPsZ73p9zFdyAjM=;
  b=jtHZwfsUmSsv09og4Ck+TMBb8o0IWtvjq/CaUiGGTiJVydLtXx/JsikY
   Za08WRKzIk9Bz+UF77m/9Gvyld6aTQvie4kYdTC5w5fdJmAECER+lHewF
   fFqQ77pZrfRpoSHuXyWq9U+S4sy5p1ommWMUtwkqRTQysNUq/gxDKFwEE
   uT6Cyz7zIAWFaP1rseFS8MOMH/sG4hqRIfIVzned0XCbj4m7rTpXWvCOA
   MtIZv5sxqKLm0ud7xjHW9kGXgG/ebT3KZyp0j+hK5d6YrsGYBhjWa6cQ7
   jxLVrUu5wlTcqQSTB34KNxUqpNEboqdFqLJjelyTsHiJUgOpGdww1VWvx
   w==;
X-CSE-ConnectionGUID: 9M1TOWyUS3Gs399QtITZ5w==
X-CSE-MsgGUID: zftR/F09TRqXj5Uxqx0CpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="35555632"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="35555632"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 23:45:58 -0800
X-CSE-ConnectionGUID: bTXVCKvfRyyJwdN566uj6Q==
X-CSE-MsgGUID: j93/jmpaRlios4Mr9W6o/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="104205202"
Received: from qz-dev1.sh.intel.com (HELO localhost) ([10.239.147.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 23:45:56 -0800
Date: Mon, 23 Dec 2024 15:42:52 +0800
From: Qiang Zhang <qiang4.zhang@linux.intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Harald Mommer <Harald.Mommer@opensynergy.com>,
	virtio-dev@lists.oasis-open.org, Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v3 3/3] virtio-spi: Add virtio SPI driver.
Message-ID: <Z2kUfHhJvODnzIE9@dev-qz>
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
 <20240326112812.31739-4-Harald.Mommer@opensynergy.com>
 <Zt7xEzOaanKiXLbq@dev-qz>
 <9442d3c7-ba72-44ee-8370-6a7bd53c2ac7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9442d3c7-ba72-44ee-8370-6a7bd53c2ac7@quicinc.com>

On Mon, Dec 23, 2024 at 03:34:45PM +0800, Haixu Cui wrote:
> Hi @Qiang Zhang,
> 
>     Thank you for your comments, and please refer to my response below. I
> would co-work with Harald on this driver.

Great! I'm glad to see you push this work forward. Your comments below LGTM.

Thanks,
Qiang

> 
> On 9/9/2024 8:59 PM, Qiang Zhang wrote:
> > Hi, Harald
> > 
> > On Tue, Mar 26, 2024 at 12:28:12PM +0100, Harald Mommer wrote:
> > > From: Harald Mommer <harald.mommer@opensynergy.com>
> > > 
> > > This is the virtio SPI Linux kernel driver.
> > > 
> > > Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> > [...]
> > > +static int virtio_spi_probe(struct virtio_device *vdev)
> > > +{
> > > +	struct device_node *np = vdev->dev.parent->of_node;
> > > +	struct virtio_spi_priv *priv;
> > > +	struct spi_controller *ctrl;
> > > +	int err;
> > > +	u32 bus_num;
> > > +	u16 csi;
> > > +
> > > +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> > > +	if (!ctrl)
> > > +		return -ENOMEM;
> > > +
> > > +	priv = spi_controller_get_devdata(ctrl);
> > > +	priv->vdev = vdev;
> > > +	vdev->priv = priv;
> > > +	ctrl->dev.of_node = vdev->dev.of_node;
> > 
> > To support ACPI, ACPI node of the controller needs to be set:
> > 
> > 	/*
> > 	 * Setup ACPI node for controlled devices which will be probed through
> > 	 * ACPI.
> > 	 */
> > 	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));
> > 
> 
> Yes, will add in next patch.
> 
> > > +	dev_set_drvdata(&vdev->dev, ctrl);
> > > +
> > > +	init_completion(&priv->spi_req.completion);
> > > +
> > > +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
> > > +	if (!err && bus_num <= S16_MAX)
> > > +		ctrl->bus_num = (s16)bus_num;
> > 
> > This is not the right way to fix bus number. You can use OF alias.
> > Also, to work with ACPI, we should use common API like
> > device_property_read_u32.
> > 
> 
> I agree with you, "spi,bus-num" should not be mandatory in the device tree.
> 
> How about updating as follows:
> 
> +	err = device_property_read_u32(ctrl->dev, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;
> +	else
> +		ctrl->bus_num = -1;
> 
> So if "spi,bus-num" not set, bus_num is initialized as -1, then in function
> spi_register_controller, bus_num will be reassigned by OF alias(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?h=v6.13-rc4#n3287),
> or dynamic allocated(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?h=v6.13-rc4#n3295).
> 
> 
> > > +
> > > +	virtio_spi_read_config(vdev);
> > > +
> > > +	ctrl->transfer_one = virtio_spi_transfer_one;
> > > +
> > > +	err = virtio_spi_find_vqs(priv);
> > > +	if (err) {
> > > +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	board_info.max_speed_hz = priv->max_freq_hz;
> > > +	board_info.bus_num = (u16)ctrl->bus_num;
> > > +
> > > +	if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
> > > +		board_info.mode = SPI_MODE_0;
> > > +	else
> > > +		board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
> > > +
> > > +	err = spi_register_controller(ctrl);
> > > +	if (err) {
> > > +		dev_err(&vdev->dev, "Cannot register controller\n");
> > > +		goto err_return;
> > > +	}
> > > +
> > > +	if (vdev->dev.of_node) {
> > > +		dev_dbg(&vdev->dev, "Final setup triggered by DT child node\n");
> > > +		return 0;
> > > +	}
> > How about ACPI path?
> > > +
> > > +	/* Add chip selects to controller */
> > > +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
> > > +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
> > > +		board_info.chip_select = csi;
> > > +
> > > +		if (!spi_new_device(ctrl, &board_info)) {
> > > +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> > > +			spi_unregister_controller(ctrl);
> > > +			err = -ENODEV;
> > > +			goto err_return;
> > > +		}
> > > +	}
> > Just enumerate SPI devices via DT/ACPI. And a fixed SPI modalias "spi-virtio"
> > is no better than match method from DT/ACPI.
> 
> How about deleting the following code.
> 
> +	if (vdev->dev.of_node) {
> +		dev_dbg(&vdev->dev, "Final setup triggered by DT child node\n");
> +		return 0;
> +	}
> 
> +	/* Add chip selects to controller */
> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
> +		board_info.chip_select = csi;
> +
> +		if (!spi_new_device(ctrl, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			spi_unregister_controller(ctrl);
> +			err = -ENODEV;
> +			goto err_return;
> +		}
> +	}
> 
> Then we can use the ACPI implementation in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?h=v6.13-rc4#n3378.
> 
> Also creating SPI devices statically based on the board info seems somewhat
> unreasonable. I agree that DT/ACPI are the only reasonable way to specify
> the SPI nodes.
> 
> 
> Thanks again
> Haixu Cui
> 
> > 
> > Thanks,
> > Qiang
> 

