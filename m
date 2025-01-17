Return-Path: <linux-spi+bounces-6394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F334DA14F2B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 13:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F416559F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9841FECA9;
	Fri, 17 Jan 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKMjGk4T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4951F91E6;
	Fri, 17 Jan 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117150; cv=none; b=FRmvRdS5F9V5MV5uEkdYI06EbWQLcwruAxkrkz91VR7QcPAoJMt71y6XPWjsTTSOwPK+XWwPNwOcG/WIJw26islZsqAmSU/rA/hrpfpWUA0IkutjOHZ9/Tj9JUGhtI8wSBdyUIU0Ba+p0RmwKNz7KO2RWXx8B9taIe5lamKTgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117150; c=relaxed/simple;
	bh=c+OiF+iR85m1JVyAcxOrHSfRVZC0aRHKC0ltq5gKUSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh9KcACrrZ22mrzcFDV5QToqs04nM6E12Je1bgkZmO2+83R1mn15T/3pcN2vukm1IVkScjEfLrHw0RXvUrAZ9yBDT09iJhesDrrFfu/Jfd7mbOgU4uDdOrKNT4Q7O1wkGAG6aVRkznktkikSboSN0Z3l09RBgMyad4/sypuWk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKMjGk4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F92BC4CEDD;
	Fri, 17 Jan 2025 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737117149;
	bh=c+OiF+iR85m1JVyAcxOrHSfRVZC0aRHKC0ltq5gKUSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKMjGk4TgHVeFMriRNDEy8kYOtw9h0Q/rMIa5eI14deZc2FwGUOBzC80g6YJbxExv
	 g+PsyLbUKa8i12p/it+w8ybTwsbzWxRmnR7g/Df64ITkxmZwFOxl4tE9xsLDSKaSxi
	 DsnzCKKBZgCbp2Zt1Jw5aYxNVReDucTWYfvXQfPs=
Date: Fri, 17 Jan 2025 13:32:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lars Pedersen <lapeddk@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, broonie@kernel.org,
	linux-spi@vger.kernel.org, psiddaiah@mvista.com
Subject: Re: SPI regression seen on ARM am335x in kernel 6.12.8 and 6.6.71
Message-ID: <2025011703-erupt-oblivion-82a0@gregkh>
References: <CAKd8=GsoKj5eG6VAMkrxMbzNyoBX=JiwafrfXman8xMNK+XU_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKd8=GsoKj5eG6VAMkrxMbzNyoBX=JiwafrfXman8xMNK+XU_w@mail.gmail.com>

On Thu, Jan 16, 2025 at 03:21:13PM +0100, Lars Pedersen wrote:
> Hi. We have discovered an SPI regression when upgrading from 6.1.99 to
> a newer LTS version. Same error on kernel 6.6.71 and 6.12.8.
> 
> I think we have identified the problem down to the reference clock
> calculation that seems to end up to zero in the spi-omap2-mcspi
> driver.
> 
> Also we think it relates to commit
> 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad, where OMAP2_MCSPI_MAX_FREQ
> is used as fallback on error. In our case it seems to hit the else
> case.
> 
> Snippets for device tree, spi-omap2-mcspi driver and kernel divide by
> zero error log with dynamic debug enabled.

If you revert the offending commit, does that solve the issue?

thanks,

greg k-h

