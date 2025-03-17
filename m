Return-Path: <linux-spi+bounces-7183-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71398A65EEF
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 21:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DB317AE43
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEE1EB5CD;
	Mon, 17 Mar 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoTKvmhW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5F1E8349
	for <linux-spi@vger.kernel.org>; Mon, 17 Mar 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242810; cv=none; b=FrNVmC0OvuBnGhcERREMAJmyNNgnj6JL0SuJBiX2pCJri+sN3+TG2weYiKEjCPmGTXWozZZ4dt3xprpjfvBGjp+9BvAQoBbWG1fRmjGWo/a5WKR024LuMIw0g7DuU5vB2RFwiYIRMh1MaRXTFWDEkPENsZQGkvXTJ4to9PTO9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242810; c=relaxed/simple;
	bh=k1lmq1AG/yBDZJCCXkmkfIKBbn9I+6nTwW0a5nGfFTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sdHmBApU1yuH++AzoVptt1yMcxCMxij8+t50D98ZKe/11itwIyLuVJR+BDDEp8My0PQYHI/95Hzih1QbVMTj0cA2Ffjnkywu7+FKfdj+Ye50HL7pn9YwBFNrgQE398fWyLCgsru0lYfUvkfiLTrgGKhQroI5A6JiRPJGfcryBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoTKvmhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13657C4CEE3;
	Mon, 17 Mar 2025 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742242810;
	bh=k1lmq1AG/yBDZJCCXkmkfIKBbn9I+6nTwW0a5nGfFTE=;
	h=Subject:From:Date:To:From;
	b=SoTKvmhWbg8havGvS7Bso8qNxXA51sSUGzvFCkRILA3F7tu2P+GS3X1LZbnB+kNNf
	 mbOg0OmT+KfmkfwVT4GIs9+YszjxB3Mw3JuA3v2JyJOa0Tn2R2VIYk1R+OKEwDJXcs
	 k9s13NRHBka/7vjU+r+PbbYyjmIlZPDMM523SujSOMgC1bZYyp+HB9UbvDY3jA0Jdj
	 yK+oKpi5fpUafigq43ONrhOtUMIi7s7oSBKVggPWeozSfQMN0bizDftx171xDypT3J
	 8a2kxwVwWnvvL0Mb6LPmgIivhbDzPPJj7Hdpne8X0JUe7NRS+S63f2hfJ+9Mf4HvA7
	 01ngIA4IQ4B6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75AB3380DBE3;
	Mon, 17 Mar 2025 20:20:46 +0000 (UTC)
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
 <174224284510.3901460.18176172712451447538.git-patchwork-summary@kernel.org>
Date: Mon, 17 Mar 2025 20:20:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sg2044-nor: A couple of cleanups
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=943488
  Lore link: https://lore.kernel.org/r/20250313111423.322775-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/2] spi: sg2044-nor: Fully convert to device managed resources
             [v2,2/2] spi: sg2044-nor: Convert to dev_err_probe()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



