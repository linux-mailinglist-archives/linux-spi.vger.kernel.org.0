Return-Path: <linux-spi+bounces-6980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29395A4B8F7
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 09:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC8F3A34B8
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696521EEA2D;
	Mon,  3 Mar 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dCLCQPkK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432A1E5706
	for <linux-spi@vger.kernel.org>; Mon,  3 Mar 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989819; cv=none; b=lUJsnBGa2hZLdgIl3ncIKj+dMTMQ1yzLalUO3FE1pyaiIkd3WP7ZIzlLhjD0KWggF9NCyUSrnFlwNP/CLoKk7cI8meXejxMHJFDLUy5TxBc2NHVlkA5hAb0dd+zeJk5EccJt9+XMLK7E/953PnL9RzFUOSz+zfpirM5bpPyt+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989819; c=relaxed/simple;
	bh=Khki82oQ8kXQPYr7Muwa6GGIg7biLqa7Oe1alJgSTs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prm91aafeNIHV4C7wZ0IBResK/4tUE60bCx2FAQFSc3gl+N9xTkQK4Xjs3eCY2BfYMR9WAcGMMGYOQ1W+FIG+AcQM8zg7UP9+l8v2USHu/p0IDv2GYZ+hbv2PoFEmTE8K+KNCt3J6+P+h4GjFeZ4Po2HSqGTNdf6Pa/sFT0T1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dCLCQPkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641ABC4CED6;
	Mon,  3 Mar 2025 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740989818;
	bh=Khki82oQ8kXQPYr7Muwa6GGIg7biLqa7Oe1alJgSTs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCLCQPkKZnhx/iRVERc45se/+9KtQeGct+uGdl0ZMu1o1iAFmm4MkY6xKtAB3BVQA
	 TTBr4TelEX8n7Q6k78CrOfWltmuua5DGP0AKbM+8rdgiN0JMGNmlduV6lCSKBW00fl
	 M42TbtQduISDhkkpNdL3xNWpUxuBpZVMT0nTEITs=
Date: Mon, 3 Mar 2025 09:15:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Mark Brown <broonie@kernel.org>, cve@kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on
 SPI buses
Message-ID: <2025030336-shank-unsaid-3926@gregkh>
References: <ee5f2de4a84c04df92644ea720b88497528004dc.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee5f2de4a84c04df92644ea720b88497528004dc.camel@decadent.org.uk>

On Sun, Mar 02, 2025 at 07:03:30PM +0100, Ben Hutchings wrote:
> Hi all,
> 
> CVE-2021-47469 is supposed to be fixed by commit 6098475d4cb4 "spi: Fix
> deadlock when adding SPI controllers on SPI buses" but I think this
> assignment should be rejected.
> 
> The commit fixes a deadlock during addition of an SPI device.  Since SPI
> does not support auto-discovery, I think that adding such a device
> requires CAP_SYS_ADMIN privilege (but I'm not certain).
> 
> Since it is intended that a user with CAP_SYS_ADMIN can deny service
> through the reboot system call, I don't think additional ways to do this
> are security flaws.

Now rejected, thanks.

greg k-h

