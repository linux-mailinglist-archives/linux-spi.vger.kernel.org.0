Return-Path: <linux-spi+bounces-1766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8BA8785C8
	for <lists+linux-spi@lfdr.de>; Mon, 11 Mar 2024 17:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE05B1C216EF
	for <lists+linux-spi@lfdr.de>; Mon, 11 Mar 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C90481C0;
	Mon, 11 Mar 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b="PlMYtU1b"
X-Original-To: linux-spi@vger.kernel.org
Received: from sirabella.org (sirabella.org [207.246.81.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00B47F6B
	for <linux-spi@vger.kernel.org>; Mon, 11 Mar 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.81.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176087; cv=none; b=Xm1xpmxb1NOc8L5enQ1Xis9cGwlgLn8XbPs2seehlGsTOyCWo0v+vQq2vNqS8ipf198vn85URTtuy+gGjAKrBgtJr0hdMl+KLwot2mVfT3HzBcZpMDtT9XaHpbozS1Za8+qjv+VKDAD9vXjcvDYsvj9vZmju27Uuub+x3H/Ka/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176087; c=relaxed/simple;
	bh=V8g/GFTJ10u9QOh5swqoUudBtkl/oNM6rfoZ5wUaP2w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG0My/o2vRhh3EKtexo8eF76dCTmXH1M3YRLtmAcwHAVR0c+Q1PfHUDTqr43ghsqHJcUVMV0NyJJB7+ynVpyCUJ5pNtokk3vtFo7IRI9PhxgtlLY6cvdwpYO51TTSZvof+3zzFlZGCEKSfVEioBRYk3Af6iSG01LRqsNELaGJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org; spf=pass smtp.mailfrom=sirabella.org; dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b=PlMYtU1b; arc=none smtp.client-ip=207.246.81.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sirabella.org
Date: Mon, 11 Mar 2024 09:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sirabella.org;
	s=mail; t=1710176085;
	bh=xUulZqFzk7zWFr7BiOrCasF9WZksilrabv7QbmirC60=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=PlMYtU1brjcWWA/5xkIcEbtqZQGWPT4TtOcyvQyVGvTfLWSTRSNoXApgtA55mjBMo
	 Y5ZxZziBPmdkCJT3u9Qr8KtXxdtTYfuA2cH/U6P39K+TC8WKMLKTWl/lop+UpXQR/l
	 gRF+2ydG0VmGvaNzij70c7M095rwpP6HFcuvQJwk=
From: Marco Sirabella <marco@sirabella.org>
To: linux-spi@vger.kernel.org
Subject: Re: use_gpio_descriptor with a runtime-added table
Message-ID: <20240311165415.ftw5pbalasjsqv7p@Ne0Ridl3y>
References: <20240311164231.ve3tlx6ib6raeo7m@Ne0Ridl3y>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311164231.ve3tlx6ib6raeo7m@Ne0Ridl3y>

Hi,

let me know if there's a better place to ask for help.

I'm registering a controller and trying to take advantage of:

    master->use_gpio_descriptors = true

but the gpio table with the auto-lookup "cs" is being registered at
runtime with gpiod_add_lookup_table (kind of like how spi-bcm2835 does
it).

My issue is basically that table.dev_id doesn't have a value that it can
be set to until halfway through the devm_spi_register_controller call
with the dev_set_name and by then I can't update the table's dev_id for
it to be found via the gpio handling in the second half of the
register_controller call.

My current workaround is to statically assign a master->bus_num and use
that but I'm pretty sure that's not what it's intended for.

Any tips? I have a patch that might fix this but don't want to jump the
gun if I'm just doing something wrong.

--
Marco Sirabella

