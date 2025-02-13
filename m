Return-Path: <linux-spi+bounces-6814-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805EA3521B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 00:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842C33AB3E9
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 23:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B971822D7A3;
	Thu, 13 Feb 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpY3ZJip"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB92753F5;
	Thu, 13 Feb 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489035; cv=none; b=MfnWVKe0SEjvRQwhzowJV9jEU3KeDnPI62wv19/wZ2TVMvlI1+EIX5rUISq6tB+83s8GbLh37nk+iNpkygzvUdfvf/VQUxdv43UDmboJAIsKUWrB2oa0BFWMg7R3OC2f+JhM8O5nHRlUkV4gPz/jCcxX5W+VWEXH4Pddc6fVWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489035; c=relaxed/simple;
	bh=I3T/QPXE7rXkGliRyzAWducT1wQiNJwF9iqVAM/6yYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBAKQohIRxXyp9nL9mm9lWJUYVtixZ/ouYb3lYnmEDRPiirPvge/epHDDg2dYSonlYNScDmwDIqIo6DGK5iKYg51h0/1x72ni4WUNcC/+UWfo7DclHFNJ5oDD+kH+cwlcMbrfr/uF20Tz+ERKPHcpPVIdq4mVHPTDuwl3MmaXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpY3ZJip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A36C4CED1;
	Thu, 13 Feb 2025 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489033;
	bh=I3T/QPXE7rXkGliRyzAWducT1wQiNJwF9iqVAM/6yYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpY3ZJipc0s2z7KGMpqX2kHkREzOcskI+bA3dmiF2wu+6k1j8sIhd+BSkwoSDKT/e
	 lq6rIUPBFlVwAW7qKU2KzquiXC7bS+Z4LWxjdH5yA8fLWAcSiqnb1xgyybbvVdvrku
	 uGL3LjY4yRhu+HMSVYg7xDmhiMrLeygDIOTbeKwVhFkOE08IpbyyqksvaKmN3iKsZL
	 PqtfdKbAZ0MZP7jzEzEhLJinyRSz/1ErIn8peXWOFTKT7YyHlEa4tMFYEdTlXqJ0FX
	 z+I3ZX58/5quzxR+yGeKf1bsLFPAFlcEq4vSi7LY3ayQ1l1IbGU6IpPl/ww4pExXma
	 oURrVKJANzIPw==
Date: Fri, 14 Feb 2025 00:23:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add tambarus as R for Samsung SPI
Message-ID: <i4gno2obchx7racy62grfb2g4zinfid7oaymsl74t65rtwsvoe@tyr4w3wywpow>
References: <20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org>

Hi,

On Thu, Feb 13, 2025 at 08:03:41AM +0000, Tudor Ambarus wrote:
> I'm currently working on a Samsung SoC which includes SPI.
> I'd like to be Cc'ed to further contributions and help on reviewing
> them. Add me as reviewer.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

