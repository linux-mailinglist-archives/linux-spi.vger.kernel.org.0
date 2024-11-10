Return-Path: <linux-spi+bounces-5660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224259C30E4
	for <lists+linux-spi@lfdr.de>; Sun, 10 Nov 2024 05:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2771C209E6
	for <lists+linux-spi@lfdr.de>; Sun, 10 Nov 2024 04:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDC146A72;
	Sun, 10 Nov 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEZEdUKy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6D8467;
	Sun, 10 Nov 2024 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731214589; cv=none; b=GakX7YNw3Jt4fHuqEhtR8K9yadN4fJXx8s8TUArDtKQHD7aBL885MxABMOZaouDivsBhQSVlp0wMJqxmonvU6nZ+9CRhA+NlvtZ8igxI/w3UdCWU55wFkgFEo/35c3EMsqAm/1k6bD412R2Mkv7SvTvvdsH78ELJnnzi6YASFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731214589; c=relaxed/simple;
	bh=mHSSYEAag1NBQNaX4d1CsjdgZdhOEG3BYJVwxJd3hgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk+KzdIY998sbzRxhogiD0RdlO8W+USWGnH65bLT6WlUVReZNrQ5ItsSVC31JD6pCzYBwNOTIhlZzTMIpVx192V8qFuAFJYocnekrbks0zrueKjQuNCMI3eKKsPb/B+GxQv0fgjSVDDpg5pWBLyEKbt7Si5iCnM44J8eGcGE3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEZEdUKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E7C4CECD;
	Sun, 10 Nov 2024 04:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731214588;
	bh=mHSSYEAag1NBQNaX4d1CsjdgZdhOEG3BYJVwxJd3hgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEZEdUKyDXBO4KPkCkNbcvt6opidOZBaxc1HXV0AWrnEEOzjCo3w+e/Ip6CE8U/p6
	 1I8fN3eQYdlZ4eY/1rnwcVxn2J6YAk/NgX6cgUFmg/B4zpK6ueubzVOYiNYL2X53wG
	 Qj0Ug7FLklA9hNi0MYBYF9FD5Xirdhg0MFPgk/aE=
Date: Sun, 10 Nov 2024 05:56:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, broonie@kernel.org, linux-spi@vger.kernel.org,
	u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] spi: Fix deadlock when adding SPI controllers on SPI
 buses
Message-ID: <2024111013-foster-tipped-3f12@gregkh>
References: <1729781771-14089-1-git-send-email-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1729781771-14089-1-git-send-email-hgohil@mvista.com>

On Thu, Oct 24, 2024 at 08:26:11PM +0530, Hardik Gohil wrote:
> From: Mark Brown <broonie@kernel.org>
> 
> [ Upstream commit 6098475d4cb48d821bdf453c61118c56e26294f0 ]
> 
> Currently we have a global spi_add_lock which we take when adding new
> devices so that we can check that we're not trying to reuse a chip
> select that's already controlled.  This means that if the SPI device is
> itself a SPI controller and triggers the instantiation of further SPI
> devices we trigger a deadlock as we try to register and instantiate
> those devices while in the process of doing so for the parent controller
> and hence already holding the global spi_add_lock.  Since we only care
> about concurrency within a single SPI bus move the lock to be per
> controller, avoiding the deadlock.
> 
> This can be easily triggered in the case of spi-mux.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Hardik Gohil <hgohil@mvista.com>
> ---
> This fix was not backported to v5.4 and 5.10
> 
> Along with this fix please also apply this fix on top of this
> 
> spi: fix use-after-free of the add_lock mutex
> commit 6c53b45c71b4920b5e62f0ea8079a1da382b9434 upstream.
> 
> Commit 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on
> SPI buses") introduced a per-controller mutex. But mutex_unlock() of
> said lock is called after the controller is already freed:

Now both queued up, thanks.

greg k-h

