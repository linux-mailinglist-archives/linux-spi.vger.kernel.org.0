Return-Path: <linux-spi+bounces-496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D618315B3
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 10:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D29A282937
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8341BC55;
	Thu, 18 Jan 2024 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh/mI/ja"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9C200A4;
	Thu, 18 Jan 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569977; cv=none; b=MdEY5L/ki3W8yT4QtJF0c1ErlXybkg+4I0Qee5uLWnvWmV7kevrcJAyNkW1dypOgJUQbFb/p7MVQ1OunLxeu1ii/QDN839g7WX/0fB2s4Rrfqsbo+j3EtuSlgRVaLP8oVptjOWpNMGTFaw8si3ggcnc/vBn2WICshsLFgtaeUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569977; c=relaxed/simple;
	bh=UijfICR2oGzBlSmNjvhFnSRNLSCWlEItBErTLdJJITM=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=q/VScoFjtAr5qkGoa0+B5mhbCH+vOGqJvImZ5UtqYV6SXVq+IxjsXXJ7TjIXlAYYVtYrL4DnJRIyaQnSXlaJV7lNch1/sdC/ei/RWxtHVw9s5kmIwTgXGxiY6mgCNJex74yNXj0AffUpHx2dm4PpbZTBcom8mAZRrLQ1Lv9xNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh/mI/ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F0FC433F1;
	Thu, 18 Jan 2024 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705569976;
	bh=UijfICR2oGzBlSmNjvhFnSRNLSCWlEItBErTLdJJITM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lh/mI/javOWw2CHp1uKcI2xFSIr52T9fq2RoncNl7lX18dV7Q6DwYsXpt/0YynG7y
	 xYJ32FOb/I/wMzF80FZJX6+HbqHG2ylB/AIt0/6zr2h1Fsxx+znpgh72lW/AvDWvsg
	 8r+i09SXhUD1mGHBf2S0ddo0/F9PU4gRtlKTFmUn2plqG1T3zHzaXBgSTLeWrjsxzc
	 MoP++Rb/iMapj9TTKDZrC0EQBSq7bbSkbRWFLsK+VGoPtrhthlDEOR9gjYIMYnuFoC
	 8/EZI960/8tftwh8EHRTqvWl0wBoXAkr4+Fj83Wn0YMxQtdrULaOtAx+mNmoZpKIC+
	 R1vt8BGmyxgPw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 30/33] wifi: libertas: Follow renaming of SPI "master" to
 "controller"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <ff935c49902f3961b602ae3b47bfe6dd2ceb8405.1705348270.git.u.kleine-koenig@pengutronix.de>
References: 
 <ff935c49902f3961b602ae3b47bfe6dd2ceb8405.1705348270.git.u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-spi@vger.kernel.org,
 kernel@pengutronix.de, Dmitry Antipov <dmantipov@yandex.ru>,
 Michal Simek <michal.simek@amd.com>,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170556997211.2797779.229676741330518699.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:26:14 +0000 (UTC)

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Please take this via spi tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

Patch set to Not Applicable.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ff935c49902f3961b602ae3b47bfe6dd2ceb8405.1705348270.git.u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


