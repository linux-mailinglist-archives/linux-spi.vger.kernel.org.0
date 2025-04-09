Return-Path: <linux-spi+bounces-7494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C520A832B2
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 22:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E031B64F2E
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAD213E90;
	Wed,  9 Apr 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ZFfrWQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF89211476
	for <linux-spi@vger.kernel.org>; Wed,  9 Apr 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231221; cv=none; b=LubOOuwPr6aPzJ1FUraQtafqSHQWRzhwseiHhm15QFEo4ALl0NzdfvocJlhBSQ+qQ1iXD2+ti5Rjmxl6auZf1nL8LQXKQG06ytj3cVPF9S/faqJDfmjsYDtgCLiAjuh8+fYocAG+hYW2FcBnzMZCh25mH8eZW3FjVrOIh8yjJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231221; c=relaxed/simple;
	bh=cFncHdafi3PpPP58B3ipsSCjFWAs7LfbCxhvxE6xlWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EAlcZDsSkYYN1BEd2aO15A+6CnBDLPhCrQLy/YCOuXlPyUk6nU0FdN/vqMI7urpn/7r/tgR2NelDPPP8nWNhOHvRmDYjHkgtNzW6Ix2XiTpITweCEeTMF1N3JThiqP2czTsUj2pVWlgrPWDTqqKRDl2n/ZxKjsVJ4ChYVCja6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ZFfrWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC5DC4CEE2;
	Wed,  9 Apr 2025 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744231221;
	bh=cFncHdafi3PpPP58B3ipsSCjFWAs7LfbCxhvxE6xlWo=;
	h=Subject:From:Date:To:From;
	b=M6ZFfrWQhfDgE/9qzO4PWbcmTzPbliY2MhWAz9LjlWW918Rcq9PHLJbmN2fyMDg+M
	 GFcQmmDnurQCO+KqnY2bl7JdXDHLyL5QhUjAIt659/XwEDJQsq7vZUGmzKp2cJ/MbO
	 Ga7SnF+4fA/dRnU5H4q79p/saNGnHMvKIJP+3koAHq7WC83X4Ah7b0cxpjyMIjJjOe
	 PUBipT9xfNQmdVwJg2QN0EZ583qT/GpUr4mfnxwnk/TEmbq2ypWRY6DY+NU3/69w0A
	 IE2WDqfCwtsCk4gilG8EuXjHHVN5tNDfF5MSx0UQOV4MFEqjdgq/QyxWab+V86K/5i
	 NiIUXuszuKQFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 768B738111DC;
	Wed,  9 Apr 2025 20:40:59 +0000 (UTC)
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
 <174423125807.2970064.11888348080936653775.git-patchwork-summary@kernel.org>
Date: Wed, 09 Apr 2025 20:40:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: spi_amd: Fix an IS_ERR() vs NULL check in probe
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=951505
  Lore link: https://lore.kernel.org/r/0e0f5ede-8993-4fac-967c-51e46b095416@stanley.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



