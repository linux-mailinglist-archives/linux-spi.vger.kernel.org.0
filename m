Return-Path: <linux-spi+bounces-5989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4479EB187
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FEC2812F6
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0991B6525;
	Tue, 10 Dec 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF8HjOEO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47691B4F0D;
	Tue, 10 Dec 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835651; cv=none; b=Ig/Q1COv5DmXq31OpIrDdywOeXeNLwMM2WTR99v8NBZlkL+nVAletixNvu5W7+9ssAFPTD3CFtR9e3OZw/pJndMDFWuJQhuqlhT3qvISyUZypVofqDPr4w5XUUQnQOsqGtX3FTHq0OhjT0YliuHJNfHCIA52ZEYF+6PD9kJLE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835651; c=relaxed/simple;
	bh=jaThpRIjcCNZ0lQjQ42i7rnft7gfMtJKkGlTrJdutek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=drqLL37M31rCYxAXunEqu2o9Z050f2v8p7suPg2OoRN5Ue/9ox+MioqDNnqQFmQ9twY0ZnC5X4qdvNtZ41WW7ZYczSsrRr03c5umCwRH5bK+VkQW9BD+OOazWTvUaIiMIArTZdw44hNsLScilr9/TUfPp1QleYYrtxOhK9QbqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF8HjOEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63526C4CEDF;
	Tue, 10 Dec 2024 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835651;
	bh=jaThpRIjcCNZ0lQjQ42i7rnft7gfMtJKkGlTrJdutek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kF8HjOEOVQLLfosqKYy2yxSmojOUK9dE5AA0qn5ypsIUCqMuvvubvy0hKGiYQ8Xor
	 6795C5de8kjVFtlMwiiO0yvBtylBAJx9uLg2QTrUhj5LBT5gc8YXjxO05YOmVhg8W+
	 0qJh03WHF00pbCa0+Watf5W+S8lygjvV2SzdapZuYoYrn+0OOjY1V3FxUylPh8QjU0
	 tQ9Jme+ujIAPmykTpGt7yA/94UwUvxyAPnO5Ouf8L27JwQK3ismNTAfGbIb5IlDVlR
	 n239MCpWHdhRAvcEwbC2K+wkt+X/bK8qXG3Qxvsbgm9FBdOXG0wlyWlvBl9AnIxSYy
	 Fj80hDpsJ6ALQ==
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr>
References: <4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: aspeed: Fix an error handling path in
 aspeed_spi_[read|write]_user()
Message-Id: <173383564913.34030.1229101307217258864.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:49 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 19 Nov 2024 22:30:29 +0100, Christophe JAILLET wrote:
> A aspeed_spi_start_user() is not balanced by a corresponding
> aspeed_spi_stop_user().
> Add the missing call.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()
      commit: c84dda3751e945a67d71cbe3af4474aad24a5794

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


