Return-Path: <linux-spi+bounces-4819-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DE979800
	for <lists+linux-spi@lfdr.de>; Sun, 15 Sep 2024 20:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0983CB20B30
	for <lists+linux-spi@lfdr.de>; Sun, 15 Sep 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F921946B;
	Sun, 15 Sep 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6Eug6aW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569D18C1F;
	Sun, 15 Sep 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423361; cv=none; b=VJb30SIuyyxVreoNREtXpYMF8CzrFSuSMu8DxXyhO02YJIabEPIlXbuImQYYSnK0lDeKxyp3RHI/ZkGfohqazmJXBH3ZlFziC+I2KgLhUnNHlwo/Qse747lxg6u9u8oYDfHD9xOKKcdwny1BrC9XVFVxTk23Z0dIC6jWdcH57Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423361; c=relaxed/simple;
	bh=6k4/XHECOk225ChNvXsCNWtARIZ1ghjxB8A7Nh3z5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzfY3xfIK6Xo4cvjw3m/1mGCntyzVdDW+WPG/M+SVDjcIS8YqKkkXUapztRX07sqW21aDE+Cl8vIKe2+QuIXWiX/Rqrvjem6rqrujKFWZGZwyaoYZIb2ErwLrn6Yy5cvW8ECh4USzV52lLjp24lyTMerES5TEOGgc8rwNSQbgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6Eug6aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AC1C4CEC3;
	Sun, 15 Sep 2024 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423361;
	bh=6k4/XHECOk225ChNvXsCNWtARIZ1ghjxB8A7Nh3z5KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6Eug6aWR9x4kUqyS4PO7NemgW8AwX3Jjyaoe7jXxpMK18+8dGP5WRYHFIshC7f54
	 NlSkxNQ/IkczZXmjHBdZ47bhbKtd7DfIP1Xe5lBiUvonpPIlD9P7s8igM15wAkqgwl
	 5AQFI/aOlZZYETRdp2cmbFyuyHwc1uOhaAM1LmfjiBJCqoV+eycGaHhmUvNa90jXqv
	 Np3VcMfYNNRMxb1O906JwoeNl4541mXV7pAecd0YEy5Q/Ax4zC32yQiobq6fhlD7e9
	 sEbhxNehp8Nyx/qBOxgHVqRJKnDZqW2xTJCwSzIYh7k7aolKojXhXcwVkD3OSUDPnl
	 1qedABguKbt6Q==
Date: Sun, 15 Sep 2024 20:02:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: f.fangjian@huawei.com, broonie@kernel.org, linus.walleij@linaro.org, 
	heiko@sntech.de, krzk@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, ldewangan@nvidia.com, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, alim.akhtar@samsung.com, zhang.lyra@gmail.com, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, opensourec.kernel@vivo.com
Subject: Re: [PATCH v1] spi: fix typo in the comment
Message-ID: <gccw6hkujwcbrb5mdokvscg5xdyvj35hwgmvpatbb2am72zrak@4sxtmkr3jg4j>
References: <20240914095213.298256-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914095213.298256-1-yanzhen@vivo.com>

Hi Yan,

On Sat, Sep 14, 2024 at 05:52:13PM GMT, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Replace 'progrom' with 'program' in the comment &
> replace 'Recevie' with 'Receive' in the comment &
> replace 'receieved' with 'received' in the comment &
> replace 'ajacent' with 'adjacent' in the comment &
> replace 'trasaction' with 'transaction' in the comment &
> replace 'pecularity' with 'peculiarity' in the comment &
> replace 'resiter' with 'register' in the comment &
> replace 'tansmition' with 'transmission' in the comment &
> replace 'Deufult' with 'Default' in the comment &
> replace 'tansfer' with 'transfer' in the comment &
> replace 'settign' with 'setting' in the comment.
> 
> 

For what it matters, there are two blank lines here.

> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

