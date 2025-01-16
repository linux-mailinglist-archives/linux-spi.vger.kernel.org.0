Return-Path: <linux-spi+bounces-6367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B6A141D0
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 19:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49678169E08
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F61DE894;
	Thu, 16 Jan 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAm16Evy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077F15442C;
	Thu, 16 Jan 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053135; cv=none; b=CKQqSjqLDmKfAosqsdR6D+F5EORgWgjzImXxREsFlzTx50NiV07TKPsBGhrRohFY3xHo6U9FD07ou8HjGqvlSYH9b1CjCxFDofo5mhn91LrZAQe+/Pv+iq1iS3996sjLAQUaEuWtKbu0U9uuxkXn6MxqWOHkX8F30c7qKKlahVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053135; c=relaxed/simple;
	bh=Rx6JqiDk5Io328mQckcw4xdvARFhgOe7jeUjdR6Tcio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G/DYfcN4YIZEHzExEfyOHhuI3zF7iKnJ07qo0HATncD1UadJjK30xNyPd9pccdNv+0d4Mcd8lv5ubKgAbhdyvxIZLdpjXOLOT3zM8HBfGqS2XDT4Fof9cXXbSVcNAGpUP+U0uW8kxGoi3ENfDqzSCBJCJOTQtYbTn3WAbCM2DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAm16Evy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E758EC4CED6;
	Thu, 16 Jan 2025 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737053135;
	bh=Rx6JqiDk5Io328mQckcw4xdvARFhgOe7jeUjdR6Tcio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cAm16EvyKBiWRoafbd8CNELUCAfOMTVr8FvGXPWt4uIU5VHACUtcgJPfcmFzTcEtc
	 oPsrFk6y8qp7wW2wvp3jyPvitz2do0fIg0jwY+YVSBKcQW60q4acHiSlmSUXDTpxNQ
	 BvGZLwxWvUrtAra7gtmX2h2CPucw4YeLHu7qNNqaDLlquVixURf2n/VXh6e6RntiYW
	 3naW5wYMtmuFNoMB16MwdRDeIiKdydnWl7Hj4Ibs4CDBnlLOR864LtUm21v1y3ctqW
	 QEFSbqcaEggoFVvLM8oot8ASZ9yJzYyqYq99VV0q5ewnU/SiYjkmMy20gYo5lrHe3x
	 ObD8EX+oa/QGQ==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20250116162109.263081-1-andriy.shevchenko@linux.intel.com>
References: <20250116162109.263081-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Introduce __lpss_ssp_update_priv()
 helper
Message-Id: <173705313363.60002.5624145474915701382.b4-ty@kernel.org>
Date: Thu, 16 Jan 2025 18:45:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 16 Jan 2025 18:21:09 +0200, Andy Shevchenko wrote:
> In a few places we repeat RMW IO operations on LPSS private
> registers. Let's introduce a helper to make the code better
> to read and maintain.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper
      commit: 78b435c9044a9ec321da29d299c70cb14b059682

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


