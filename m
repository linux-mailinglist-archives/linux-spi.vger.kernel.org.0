Return-Path: <linux-spi+bounces-8331-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8073AC7FFB
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49ACA4077B
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA422CBD2;
	Thu, 29 May 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiPKhwjJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B322CBCB;
	Thu, 29 May 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531240; cv=none; b=Co+QI6zfijAdy/k3DZE+S2c/id8QzZIEfiCAguKRoY4cFRkA//TSVkCgJQm4S/JBV4IqWJWb10urCcW+84WcyVOZSPEN3WFUyNADp1EglbJZYX1/DzUnkxetpt4AM8vwIUk2HpWrn5jfoj60QlnDyr2h3u7uJhQ7OWr54lLvj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531240; c=relaxed/simple;
	bh=oIikqErvY0/2Yw/HLI970NexWLLJ2jSpoVZKtL13Ib4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SNvVlBuDZHvNoprjq8Mc38l5/hXSSKqgeIxRTylv67MB4XqP5P9ZUOLv6vXQtuqfXXWZyN2ilPxvO8mxlOgOz3u8kMz7lu9v0oSs3W1Au5Dv+l811uqZ5EutfRtfpDHyG4+YAXAdqqQ9CXH5dYUTAUYF+/WSsUitsav0ncyobHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiPKhwjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D702C4CEEB;
	Thu, 29 May 2025 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748531240;
	bh=oIikqErvY0/2Yw/HLI970NexWLLJ2jSpoVZKtL13Ib4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uiPKhwjJuYwyK/zuMgpElLDGS3i4ExNLt0O8h3MjAF8Mr+t9Wx7X/tmtqtohiW7aE
	 YW3srUc5qpkkSxVKBq7e7tPYQ31GCCmOtLICTkfE6XWnAPB+7uXqxmTqubDOEX7QGM
	 kBuwpmsvZn/pS/TpuIT5/kqo2JfyHAlMwoodCX2MMBLEdkxnkSAJjOK+JXhDsvL+pf
	 wxqSCezhltVEC+WwQZcBNQ0/ewaJxk42nOVtRGvWnJ5Nxt3MAxjREfXboE9b5sIfPZ
	 y+nJEMx3xY9LMwB0q4ZHeVwHW1K0USjC3cQ++DUi00Z+bVdqxn/Aijx/c0iQ83mICG
	 CzmLgDdbXZmqA==
From: Mark Brown <broonie@kernel.org>
To: prime.zeng@hisilicon.com, fanghao11@huawei.com, f.fangjian@huawei.com, 
 Yang Shen <shenyang39@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20250529061704.190725-1-shenyang39@huawei.com>
References: <20250529061704.190725-1-shenyang39@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon SFC driver maintainer
Message-Id: <174853123887.49583.10719064798255686718.b4-ty@kernel.org>
Date: Thu, 29 May 2025 16:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 29 May 2025 14:17:04 +0800, Yang Shen wrote:
> Add Yang Shen as the maintainer of the HiSilicon SFC driver,
> replacing Jay Fang.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Update HiSilicon SFC driver maintainer
      commit: 589561cb455189154a7110a39d9fcc39965f3104

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


