Return-Path: <linux-spi+bounces-10683-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F182CBE0414
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CA354E33
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFEB273800;
	Wed, 15 Oct 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J22rDMBQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3822701C4
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554220; cv=none; b=WN++BvZEV+a51cXOwIrMW8+ItiaWvJ3f94Dxgs8ibi6RJSgqYr89Lmpd4RqEbZJ7bKnluXBhuqoQy0oe3sDTzsEHQ09S2lrTPR+kxX7AwTpehygB0Rs1XK2q4dmEcEkvpm1C6zpYREn/1NwlHQlpVIqjoNmnOB0/rvyK+rVr4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554220; c=relaxed/simple;
	bh=YBEX8RokjGfScCCGordXtVx2JrNIzE2CCoul3XAHDvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YrKUHsgl927fR6zTsgLduopYWfBkBFpCbDnj+Zp/77EngqzXP0G3TdCFUyLaNcFkLiPtKOmWR0t/Kf1mAA9+GpZ95QDT4ZK9Fh9WrXRHX3W++WJNHgQ1H5VNorJ28BuRdm6l6h9ty1jvtZcE8shhTFXW3jYnZThE8JbikoNC6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J22rDMBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D660DC4CEF8;
	Wed, 15 Oct 2025 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760554219;
	bh=YBEX8RokjGfScCCGordXtVx2JrNIzE2CCoul3XAHDvs=;
	h=Subject:From:Date:To:From;
	b=J22rDMBQSJ4n9uceL3C9a7pJhYZ/oUI3QTN3FPFE3YtpQr0x3KT0gBMheX2Hc/sGP
	 ENOMx7gd/QrthzcsGUU/p9AnBKjsLz/iOhvD/q5lSH/33mkTX6wczTA2dakHHct3L7
	 IcT9+fHS3VBEb0hmFKPlJ+HLzu+Z6XIUeZKYB30Wzvs7tQDZ39L65xZGHDSqfhE2Kk
	 DulZBfo92qIoWNafhj1AQDrivAaRNrReYEZqIFi3bJfrXwtEZpr8vee4ZUDBuu7+xc
	 NT3Bea1gtFAlzgmRWuSt9+9N5rFb64kI3rF4mLurjvdWTo1FErLQOvdmr2n5UOMxz8
	 g8VCbirOCEXdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2D65380DBD3;
	Wed, 15 Oct 2025 18:50:05 +0000 (UTC)
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
 <176055420430.1003679.11002410509115283059.git-patchwork-summary@kernel.org>
Date: Wed, 15 Oct 2025 18:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amlogic: fix spifc build error
  Submitter: Xianwei Zhao <xianwei.zhao@amlogic.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1011709
  Lore link: https://lore.kernel.org/r/20251015-fix-spifc-a4-v1-1-08e0900e5b7e@amlogic.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



