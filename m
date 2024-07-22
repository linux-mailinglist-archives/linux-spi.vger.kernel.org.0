Return-Path: <linux-spi+bounces-3916-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C8939116
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653431C21412
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0A1598F4;
	Mon, 22 Jul 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slfpDzXU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFA8F66
	for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660208; cv=none; b=TE79akGcDtKLm7jpU3yo5+4kBkMa8TnaDF4vBf4DT5kd8ujwmBwnsmZIkTIrSvzZnxjIV7TBQm4myjBoRxQURhThBsJihAJYZ2MnkZrKO32d2m5OybnZJJOR3Z5sPiIED6zPyi+nvE4wDKpapXS2kBwbi1p7VSpgC2jy137ImFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660208; c=relaxed/simple;
	bh=TSSbek2jbmv0ccZk1ShOgoNlm/IRKqxTMtlBeoHQ+Hc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DL3JAGn4aGsL+V3YYzm91HWSwPAyE02QG63FJVCs01oDU686Fye07llnqr4Nix0KyNg0sksEY/uztj6jhz94jQJ5bIWPhLrSXWj9MJPG37KWSpVH5DduNCFHCK5NnmwLBS4DPkHI7nLW5SdIinrU/ia1X3DO0u4cJX1qTLNSDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slfpDzXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 509D9C116B1;
	Mon, 22 Jul 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660208;
	bh=TSSbek2jbmv0ccZk1ShOgoNlm/IRKqxTMtlBeoHQ+Hc=;
	h=Subject:From:Date:To:From;
	b=slfpDzXUTWoyGC2qq/Y59t3ksqv7M+oCqYQ8JLHdpeS6ZlT2sWS3HhneSwy67IhaS
	 5qejA3rIBHVH9UUs2KI/8uJNXHdB6SeU3RUtWEPo+TWKyQuBz/Ob7BNwbajHodIfpd
	 a0qVQu+bnYbFxYILFQMfgeOXb9PdZGb5oKabCQbfQx2DDaTeQyD0JLNVmh7tLzthcv
	 3b7Z0rVokcrjfxoQiJgsaGjUTZUtg3q4sFxDInEW6Ci0j3iQGEkOHlohZM1zK1wXa2
	 dFdStj7aFzVTVZNGs+f5P8cY1JODYGuzCPwKuiiYfUXAmrPpC+X03duHtXOzikNtvd
	 qq2JlWHRD9oAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C2B2C433E9;
	Mon, 22 Jul 2024 14:56:48 +0000 (UTC)
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
 <172166020823.22107.9547655991640858493.git-patchwork-housekeeping@kernel.org>
Date: Mon, 22 Jul 2024 14:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: ppc4xx: handle irq_of_parse_and_map() errors (2024-07-22T14:18:22)
  Superseding: [v2] spi: ppc4xx: handle irq_of_parse_and_map() errors (2024-07-22T12:35:19):
    [v2] spi: ppc4xx: handle irq_of_parse_and_map() errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


