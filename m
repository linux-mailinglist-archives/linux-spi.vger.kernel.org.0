Return-Path: <linux-spi+bounces-188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8E80B444
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 13:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EF328109B
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D613FEC;
	Sat,  9 Dec 2023 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBWcRGyd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187711184
	for <linux-spi@vger.kernel.org>; Sat,  9 Dec 2023 12:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF997C433C7;
	Sat,  9 Dec 2023 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702125626;
	bh=u+RQy5s6LOMNgqUNAF3Ukr3zAIklaR8+S2MICOfdtjE=;
	h=Subject:From:Date:To:From;
	b=sBWcRGyd8+bBM87pZQ7v1pbsAlLPFm/aKRHIo892dVGz2Yms/B+UM2CpLcvfOg58e
	 xqiGIMegGZoQpIxOmgTFktNguhWNPEnAgj1lFOk1+5C7Gvz1tg/YDfIxF9v5Hdb0kM
	 WX5vnO0Xm+TyKC47KOSE+a3lrBuvsD4FtiAzxybHldHukw6rWNlVHDwlEu1CJtbyq0
	 TNFagkca5oeNvd5GZsF+zokHdrpH+Zli/9HxRx05XPHjzGibxCXs8b+mWPPHHhMYqY
	 ZgzeaFRZUUGOTKp/MaMDdPkgedU9mjwFGc70oR6DGKBI58MXhNGnpemGQG4rdGYV9K
	 6aKEK4GWY8tMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4E6BC04E32;
	Sat,  9 Dec 2023 12:40:26 +0000 (UTC)
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
 <170212562661.17925.11123798984003466161.git-patchwork-summary@kernel.org>
Date: Sat, 09 Dec 2023 12:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: mpc52xx: explicitly include linux/platform_device.h
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=808360
  Lore link: https://lore.kernel.org/r/20231208185927.14124-1-rdunlap@infradead.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



