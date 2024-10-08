Return-Path: <linux-spi+bounces-5148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F0D995009
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C438285322
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE211DF274;
	Tue,  8 Oct 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XB+6xxLk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A31DF263;
	Tue,  8 Oct 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394269; cv=none; b=L4+Scty9ido1RNwxM5JW0gA0XXglzbOeF6Ptd7xEsNVAj5Nu1qVYejYVeELAsx2avFRkw+d+yevYFi8XcZVRR5OL+KcueHKJiI90I13dS8Qi8zbuDQAlAPwINd1exoXrfJD6cWzhDMM2eDJMdo/VY5q1vvb1JnyrK2WoK+ITEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394269; c=relaxed/simple;
	bh=VkLg4Yp5h3hnS3U7tHlCL7BPi28EBnRIH+jX7y/NtO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV2sHm3n1dcV3zK4cebQhzTrvtIRgpeCqch97xAC1CfjwXtPJQhVr4Ba9V4w/W1SpxMyaHn1UT6Q0u7JbLy09nKQrA3AF/7mVzpIlSiYeI+2H+G5fTlQ9cZ5e/fewbBdOP1jY+pILbC0u5K6eRh1H/52b4YdlSLr1BaRn3fFedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XB+6xxLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578DEC4CEC7;
	Tue,  8 Oct 2024 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394268;
	bh=VkLg4Yp5h3hnS3U7tHlCL7BPi28EBnRIH+jX7y/NtO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XB+6xxLkxXBYLihVlaeUGOIejnMzteJexCwex7LhbfBEA+p+JagD3h+2IKHntLT9+
	 iDp+CYQPIEe67QJDhxSTNBqoKNFSZTPYCWp0t2epWrmTUYVw679oYfkG4PNMGxlnDw
	 f4J+nTLpA1Ic2lPrG1S+SZtRIOK4NftcR/8V7zJU=
Date: Tue, 8 Oct 2024 15:22:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	broonie@kernel.org, heiko@sntech.de, rafael@kernel.org,
	oss@helene.moe, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <2024100852-esteemed-cosigner-a70e@gregkh>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>

On Sun, Sep 29, 2024 at 11:21:16AM +0200, Dragan Simic wrote:
> Some drivers can still provide their functionality to a certain extent even
> some of their resource acquisitions eventually fail.  In such cases, emitting
> errors isn't the desired action, but warnings should be emitted instead.
> 
> To solve this, introduce dev_warn_probe() as a new device probe log helper,
> which behaves identically as the already existing dev_err_probe(), while it
> produces warnings instead of errors.  The intended use is with the resources
> that are actually optional for a particular driver.
> 
> While there, copyedit the kerneldoc for dev_err_probe() a bit, to simplify
> its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), with
> the necessary wording adjustments, of course.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/base/core.c        | 129 +++++++++++++++++++++++++++++--------
>  include/linux/dev_printk.h |   1 +
>  2 files changed, 102 insertions(+), 28 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

