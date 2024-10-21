Return-Path: <linux-spi+bounces-5291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A19A9377
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 00:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86850B219FD
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C23137750;
	Mon, 21 Oct 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UysB9qVQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0A2CA9
	for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550421; cv=none; b=VZWm+TgFMZF8JmgUovP69Hnl6WfwkskXESwmR0L5c40i6dcoC4TF1k0xObCWUHejmH0o2ZxxP0/4ye5CsBaniK1M1pQLWCNm1MEWbYY+tDQXkCWy9Q9OdsMlJoRvKClR0qPhFHrjM1DVkZiw/LjkioOWhaAVgViJrBLgiLdlUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550421; c=relaxed/simple;
	bh=hKKHguQte5Rlp46+A43tR1BrUWWHTyVEoCwGbxJRzuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=k5o/y9mIxhfHuTISgrEv62UDcB5hwtQk9FVtjUyUOpWPxETxpzTsSdWr8inPzM9pIWp6seoSic3BnD9x+1B5TdDETmJ047pAB4nJWBW1fPI9VO9fnGsW5JAaee5FLFJOGVInM1dPkwBd1k73CKy+zSYMQjEMkFmjy3hBRRig+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UysB9qVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA403C4CEC3;
	Mon, 21 Oct 2024 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729550420;
	bh=hKKHguQte5Rlp46+A43tR1BrUWWHTyVEoCwGbxJRzuw=;
	h=Subject:From:Date:To:From;
	b=UysB9qVQHCzXlpoVe+gdeHI7iGCKK6FMG6f3KofI4voZy48M5Rb+947LzQBsUAmbs
	 N7FAwp9oGUkJ448rS1pmUtN9hQvDNzYlQWMDCkAAtDy+Acls0TLGdFJP071mg4eWRT
	 c1NZGRsouZGX2dQI4oOICn+5t0+W10HfRarvs3WqAFNS5jKIALRCxcbapQov390PG8
	 WmmGSUiTO0WoS3PDMKXGvXQLa/8QNJMV9UBaaKiQ3c2+eWSuollp0BZpxN8e55gue9
	 /UmBzR5/thPDQuuv1Ns5i7zfJuPOsmj+DbhiMitEsxm8Y6eCNwwtx9ya08V5c/o2ZN
	 2zouMThL4Z6ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF5303809A8A;
	Mon, 21 Oct 2024 22:40:27 +0000 (UTC)
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
 <172955042660.466664.3507185591562228453.git-patchwork-summary@kernel.org>
Date: Mon, 21 Oct 2024 22:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Realtek SPI-NAND controller
  Submitter: Chris Packham <chris.packham@alliedtelesis.co.nz>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=899533
  Lore link: https://lore.kernel.org/r/20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz
    Patches: [v5,1/3] dt-bindings: spi: Add realtek,rtl9301-snand
             [v5,3/3] spi: spi-mem: Add Realtek SPI-NAND controller


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



