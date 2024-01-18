Return-Path: <linux-spi+bounces-491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AA8311E6
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 04:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBDB1C216B9
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 03:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709876111;
	Thu, 18 Jan 2024 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks86j/bU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDA6104;
	Thu, 18 Jan 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705549772; cv=none; b=J4LGh4mhPxJUdykGDs6Idy+yBPbN8EskaadYSIudsEXdIdnuvRQJkGCBxAlhhftvGkOQyqSnTRu9a5ut1t58zFxIRWeht0ePE0BKSHey4NJ4NDlIpC7sZgjwFPSPhHqxv2kKJAKYaNQuTlSLkd4OdgQAHQn4w0VSd362ZzYsEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705549772; c=relaxed/simple;
	bh=SW6J3KJ/2V7vVLy6IqqIwAGM8Rkbbyok6f8Pnxb4H0E=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=gATWXeMGZSqfMAhuQUYPwDwWmUgG9Qsr4KJf8NaGrQywv7gU6tinkigjUA4eVlKocRTnY3vCVKNhQlB7Rkk+ElqhOjcr2K2Gy27AGbpNG2vVBuWlkpFUIQ6J68uFT1M+iKmjNnFIyRhcjlQ1wbxRvdtYDkSECtbD1mxvuyw/+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks86j/bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A9FC433F1;
	Thu, 18 Jan 2024 03:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705549771;
	bh=SW6J3KJ/2V7vVLy6IqqIwAGM8Rkbbyok6f8Pnxb4H0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ks86j/bUXbmDTL9MaY67LXrkdQBL4lLZA3rqtB/+0wM88Vm/QCP2qlJTOM6tu2Mbo
	 B1z+VPVqdBzPCIKVkl1bSLujx88Hf6ICVhwCdSzFnoXy38jTgzmrs/AtZt7cV9ZrFi
	 EQS3v7w6b3JwFEyxW9EGjRPMfLtbA8J0JIXXk91LF0jFkbQOtTVRPQJj9SOfLNtK9u
	 X/cf1k7qaSJ5WRSn1IbWTBO+BTQmopvivGy+4MZGm7blRDdnz1s7pxAM8z5ZNXUSxn
	 FuJgnpIm05ddfoGHIyoVjWbGAuBeo2QGxkvwtFmqbjnHXrTyW/tsgYUgS5nlRvp6N2
	 ymKf9GtXu7gMw==
Date: Thu, 18 Jan 2024 11:49:28 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 16/33] platform/chrome: cros_ec_spi: Follow renaming of
 SPI "master" to "controller"
Message-ID: <ZaifyLr_Z3pG4hZR@google.com>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <8ae71cbe62a853fcb7546e79bc319556855c3800.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ae71cbe62a853fcb7546e79bc319556855c3800.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:13:02PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

