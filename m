Return-Path: <linux-spi+bounces-10162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D306CB89D6F
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418A4A037CE
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF00317704;
	Fri, 19 Sep 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTg/Mbcz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40849316919;
	Fri, 19 Sep 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291106; cv=none; b=NNCuqcstb10ZQUgWQKtUEH7J3RV3yjlDE+buLOGz+hPhScUXXOWDt/EC/fKkidM5zqdcUSsMBPyS2U4RcS20WirfJMiLaF8/fJGNVeyQ/WTVnbCxH/pz/n9KIbx3Bv6Bf2m3xxU2BzCz/DWefadDsZ2quuaPhq6DNg+4m+ruQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291106; c=relaxed/simple;
	bh=hsonhv8rhrHBq8kh44j7t00uQIf1Udf67JBnbWlzHpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nCkX+A0HsfOWTzA08iAutD6ZQs9NIVhvUauESosfoyC4mwpDBUD5H6g2hyRvOYMo317exjLQtXbiq5zdtnrwR8dcgFauWkEm7k0n1+zY8TW2LeT+l5E5gQ1eoGa11BQagG5fiIq5TKQucKhXdbVEUfsY0mW8RaVhJuTGD8sT/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTg/Mbcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857F8C4CEF0;
	Fri, 19 Sep 2025 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758291105;
	bh=hsonhv8rhrHBq8kh44j7t00uQIf1Udf67JBnbWlzHpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lTg/MbczH6IQYx+xZX0ViVzRiElqSvyC9wE/GbLnS1N2eXxBqaH4yI/SiPfhwN2W0
	 J6p00wrU0fmUm9VGDzjwo8DHdvzxFi04hvVnsaooRoL8uXGfGuFJXO6L6a8YWQe97F
	 E1IpMWpQIqX0aRqzkENLTg2HTv5XNi9Qa5L585Q+MkvnZpaL6cy507AiR2hh0VOlAw
	 UC0oVYV+j6BH7e4L1GLBpct1RcZO2tx3TSwavOE7j2NKmchPlMrwIYuICztX6ISHV4
	 ULsJ6BYi0TPkx3gqD/2Da36QJOL6fY/vPnPz7ecdk3WSmkzZ/yGcFRUFjb33xEhzTZ
	 DPop+SkdXnh5Q==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250916-qpic-snand-devm_clk_get_enabled-v1-1-09953493b7f1@gmail.com>
References: <20250916-qpic-snand-devm_clk_get_enabled-v1-1-09953493b7f1@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: simplify clock handling by using
 devm_clk_get_enabled()
Message-Id: <175829110428.130975.7186630185798573706.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 15:11:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 16 Sep 2025 19:43:46 +0200, Gabor Juhos wrote:
> The devm_clk_get_enabled() function prepares and enables the
> particular clock, which then automatically gets disabled and
> unprepared on probe failure and on device removal.
> 
> Use that function instead of devm_clk_get() and remove the
> clk_prepare_enable()/clk_disable_unprepare() calls in order
> to simplify the code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: simplify clock handling by using devm_clk_get_enabled()
      commit: a24802b0a2a238eaa610b0b0e87a4500a35de64a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


