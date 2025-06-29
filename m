Return-Path: <linux-spi+bounces-8869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A0AECED3
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4731895144
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994B235341;
	Sun, 29 Jun 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhCuK8dn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519A23507E
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216283; cv=none; b=iXCzEtGNgol0lPXSoV0S0RieJE9AThb/d1+lZOlX0Nbmp1yAzqYuiB6fOpzk/tLD+9sJYdraQwOO+CCFuR40GsELjxH7LjKB/FeDUhvGsGx0BJ4o9Q0LINnMLWz9+OZALGbcXc6srH6rnZGXadifAZw7mVt5kslFZaozjTTVBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216283; c=relaxed/simple;
	bh=EJNXb1vZXvgfsq0bovhm/FuMYMnxUMi7iSEWEeySOzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NBFsWfEJpWSmAT5788dhK+QnJPQfr94R64DUh3Moj9LDUEomuALHEDqxdg3OCtUmmJiKMISbeypbRjA3KaDsSRlmObyAwHzz18FLMaRH9SbFTUdvKN/SBDgFW7Gb0vBHyGQYmgvtBq6rMmtgJ30LkDk7J3FvPiIJwlin8Jcz/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhCuK8dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BC2C4CEEB;
	Sun, 29 Jun 2025 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216282;
	bh=EJNXb1vZXvgfsq0bovhm/FuMYMnxUMi7iSEWEeySOzM=;
	h=Subject:From:Date:To:From;
	b=BhCuK8dnLddkr/qC0R2at4lcEB1H2l0xORMPcyqWzyZpbckEJBbO9r2uyj81bUtum
	 gJZfGR4yB2dBbaiVKRx5ya6b09iFMocF6R1LnvVVx7ieGKylxb6yhxzrAmBYeuUFDl
	 XPQL25SR7yAdnHG8hTxFnHW81rp6LTIzvcJ+wuHiWvR0y8mRGHrHZMQRxE4n2PeFJA
	 BJ6jdEwfI86URPQFerApAm4alF/1bkSzer02+0zRV6OocQdVN2YKJlYObNqsj06hwz
	 oDVi/01spAK02VwtWGpPyeg6UmTSNm9R7NNbIHYJmX4xC+waQeA6MLDehLbNdXnsN4
	 NQmbGdz9qcQbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 748E338111CE;
	Sun, 29 Jun 2025 16:58:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175121630802.2434268.17135599879705786611.git-patchwork-housekeeping@kernel.org>
Date: Sun, 29 Jun 2025 16:58:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Raise limit on number of chip selects to 24 (2025-06-29T16:15:32)
  Superseding: [v1] spi: Raise limit on number of chip selects to 24 (2025-06-29T16:14:51):
    [next] spi: Raise limit on number of chip selects to 24


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


