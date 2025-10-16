Return-Path: <linux-spi+bounces-10705-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA0BE5262
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48159583B68
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940E23BD06;
	Thu, 16 Oct 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsP9VTfI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489F23D281
	for <linux-spi@vger.kernel.org>; Thu, 16 Oct 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641223; cv=none; b=oUesQi2DX80sd2OwVj9a/QaL9c8J9ZK8bfBz/wB/26rXOHHWATd7KWFo47Ig94Qntx/R1qtsBZFUGGz3/hIJh/OJyscpULAKAkI0dhag7aaiN5sEhzxXj1tZ7TrsnpdNW9Ud1TqafqhK8ZqSoNNRF5ilSEZbH+QAKWbaRiKc/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641223; c=relaxed/simple;
	bh=v1FVWVncA3PIw1ySsGsPbMrOx5k04+vMtAOYExcXPxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YlPhp6iWC7zdldw5j/T0il5+1/0DQzylcQeaaP+migFBu4GKqpEsD3wkCKGwV9sCYGqIJ20Ih6z6yUTnF1wM8gmuSGl3p9Ln/svvxGccSNe2atgghPDg4zDGrTHMUrGmMUTXTcgctoVmu13F6/BsSM9xAu6P1wio/VtULFpwJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsP9VTfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42689C4CEF1;
	Thu, 16 Oct 2025 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760641223;
	bh=v1FVWVncA3PIw1ySsGsPbMrOx5k04+vMtAOYExcXPxg=;
	h=Subject:From:Date:To:From;
	b=lsP9VTfItTR03ujt8PEK2ICjGPnbp7amYjhvLZ8LDDvw0vtdZkueGSbhI9hthzuE9
	 ZkJIV4zMb/w3ZkvfSl6sIw/Yb9WikwbDXqY6TchyUV7u/t8mXb1jpJ0XxgP+ErNCHV
	 Q9lGG6KU7rWG7FlttyNw1OQwABMSm2c6GJdXS/8LLJKlq/5Xqoohv/Da4crpq69Vox
	 QLfCk7+O+cqYoKh6tRbhLm0RGhjAgWOerj7qBQ+AzfILKvcsoIr8h/7PtyqiJVGhv/
	 yWcwzzKvOzpKVPzoJh2lwovEq+AGLXU88K9FCqtU4igVJK+yyP/Ph+JRHTo1Oao4RT
	 hyHhFiR8LQ4zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A62D39B167B;
	Thu, 16 Oct 2025 19:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176064120710.1866046.13503072802832697978.git-patchwork-summary@kernel.org>
Date: Thu, 16 Oct 2025 19:00:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v8,01/15] spi: airoha: return an error for continuous mode dirmap creation cases
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1010199
  Lore link: https://lore.kernel.org/r/20251010192038.1592889-2-mikhail.kshevetskiy@iopsys.eu
    Patches: [v8,01/15] spi: airoha: return an error for continuous mode dirmap creation cases
             [v8,03/15] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
             [v8,05/15] spi: airoha: switch back to non-dma mode in the case of error
             [v8,06/15] spi: airoha: fix reading/writing of flashes with more than one plane per lun

Series: spi: airoha: driver fixes & improvements
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1010422
  Lore link: https://lore.kernel.org/r/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [v10,01/16] spi: airoha: return an error for continuous mode dirmap creation cases
             [v10,03/16] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
             [v10,05/16] spi: airoha: switch back to non-dma mode in the case of error
             [v10,06/16] spi: airoha: fix reading/writing of flashes with more than one plane per lun

Series: drivers: mtd: spi-nand: fix continuous reading mode
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=988245
  Lore link: https://lore.kernel.org/r/20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [1/4] drivers: mtd: spi-nand: fix direct mapping creation sizes.
             [4/4] drivers: spi: spi-airoha-snfi: return an error for continuous mode dirmap creation cases

Series: [v2,1/4] mtd: spinand: fix direct mapping creation sizes.
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=989538
  Lore link: https://lore.kernel.org/r/20250808210147.3085391-2-mikhail.kshevetskiy@iopsys.eu
    Patches: [v2,1/4] mtd: spinand: fix direct mapping creation sizes.
             [v2,4/4] spi: spi-airoha-snfi: return an error for continuous mode dirmap creation cases

Series: mtd: spinand: fix continuous reading mode support
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991325
  Lore link: https://lore.kernel.org/r/20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [RESEND,v2,1/4] mtd: spinand: fix direct mapping creation sizes.
             [RESEND,v2,4/4] spi: spi-airoha-snfi: return an error for continuous mode dirmap creation cases


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



