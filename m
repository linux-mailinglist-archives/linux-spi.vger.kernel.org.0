Return-Path: <linux-spi+bounces-4744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBBF971A32
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EAD1C21A51
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685FD1B4C4F;
	Mon,  9 Sep 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgzP5tMw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27341B81B6;
	Mon,  9 Sep 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886785; cv=none; b=WTAWUnJHdchg3gyBsr0hfZPr7gpp6tbEA3A63eS0R61qAlKdbiJFXK89xDrYXHRyyKZ53CXQF4wfA/CZ//yoK0B6fCKAkqTjlQuObqq7wrlTNfyxlbVYden/FPmvctSnDnMWZQnB5HvcxFtSHU70Hh6VmExmbGOKB00+dhR7FKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886785; c=relaxed/simple;
	bh=62fE69/qRsXQa95/gZo80+ESJhQZVx/zQG23PYTQDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr2Ej4SASiUnE84Ti30foVYu5Sdivb4hQwEFpxuTNcWu55Hro4ZG+pf0bVihWJapCoTji4+QQHDBU0G/AZ1xdD1JLY0eV+xZl9z89Hqh8IsJaKAZio7tssSFIFqjgW4UR/0Bvt1FHiDi5z0KXupc16a3UcKmrlerPsFksZBoaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgzP5tMw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725886784; x=1757422784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=62fE69/qRsXQa95/gZo80+ESJhQZVx/zQG23PYTQDaM=;
  b=AgzP5tMwSvvmXHaDuLMb6loJFdzsO4oVKiwK5lXwOkN6CfL/BKASeSS0
   4uitMa23eKQ0G1wTumCsE9qf/S6EaWX6upe2I9uo+9BbDQkMIlyi3R3hp
   ZvVc6txQoGrSO+ORSAOG5SROkUb7KPTxbYII9dHF0QT0IIVgYlRHr8GNC
   3pyndcEkNny1rEylVSavzlMVj2YC7cJC+DXAKdcLfvT6g3O1AJJ29c9h5
   ouNthcKhpA2+EXWC0bU6//ysEBXQJMu02F/HZBsdqhta71PpMbI5wAHYY
   dwwL76rWVhN+Z1dP6O1WkBpnwgkX0zfqcjceEoIoJts0DEWrgBu+mdra3
   Q==;
X-CSE-ConnectionGUID: EUK8Up98TAexOLlwhsrCXg==
X-CSE-MsgGUID: APfgrZFETXOxfZZPz8RyTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35722983"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="35722983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:59:44 -0700
X-CSE-ConnectionGUID: bCEw3gONSHeLoXfGVns2GA==
X-CSE-MsgGUID: hnf3Mk27QkOfc3sQOkC64w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71077783"
Received: from dev-qz.sh.intel.com (HELO localhost) ([10.239.147.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:59:40 -0700
Date: Mon, 9 Sep 2024 20:59:38 +0800
From: Qiang Zhang <qiang4.zhang@linux.intel.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v3 3/3] virtio-spi: Add virtio SPI driver.
Message-ID: <Zt7xEzOaanKiXLbq@dev-qz>
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
 <20240326112812.31739-4-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326112812.31739-4-Harald.Mommer@opensynergy.com>

Hi, Harald

On Tue, Mar 26, 2024 at 12:28:12PM +0100, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> This is the virtio SPI Linux kernel driver.
> 
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
[...]
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct device_node *np = vdev->dev.parent->of_node;
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;
> +	int err;
> +	u32 bus_num;
> +	u16 csi;
> +
> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	ctrl->dev.of_node = vdev->dev.of_node;

To support ACPI, ACPI node of the controller needs to be set:

	/*
	 * Setup ACPI node for controlled devices which will be probed through
	 * ACPI.
	 */
	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));

> +	dev_set_drvdata(&vdev->dev, ctrl);
> +
> +	init_completion(&priv->spi_req.completion);
> +
> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;

This is not the right way to fix bus number. You can use OF alias.
Also, to work with ACPI, we should use common API like
device_property_read_u32.

> +
> +	virtio_spi_read_config(vdev);
> +
> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> +		return err;
> +	}
> +
> +	board_info.max_speed_hz = priv->max_freq_hz;
> +	board_info.bus_num = (u16)ctrl->bus_num;
> +
> +	if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
> +		board_info.mode = SPI_MODE_0;
> +	else
> +		board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
> +
> +	err = spi_register_controller(ctrl);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register controller\n");
> +		goto err_return;
> +	}
> +
> +	if (vdev->dev.of_node) {
> +		dev_dbg(&vdev->dev, "Final setup triggered by DT child node\n");
> +		return 0;
> +	}
How about ACPI path?
> +
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
Just enumerate SPI devices via DT/ACPI. And a fixed SPI modalias "spi-virtio"
is no better than match method from DT/ACPI.

Thanks,
Qiang

