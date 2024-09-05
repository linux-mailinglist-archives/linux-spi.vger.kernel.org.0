Return-Path: <linux-spi+bounces-4663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CA96D4D1
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62722280E53
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797C156225;
	Thu,  5 Sep 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLZXLkFU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489E194A64
	for <linux-spi@vger.kernel.org>; Thu,  5 Sep 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530195; cv=none; b=pchV6TrjT0qHS0LJfBdQ2TKjXoAADj7S678pB0n66U8pmtbOVQBm2jJbj+c+V8V/fNWvardEEn+YUBsizZLsKMDvFQfZsVj2vRLhnRVszH3Jeqgjg14Nt/1W3eO5yjXuZg2ZJ8TW/w3ljSdgCIqEQ50PZ+XhYs8u/12lH1GRkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530195; c=relaxed/simple;
	bh=NMLYodRhAdp6JxgRNb9lmDrOKaJNPSIliyz/0rQ9erE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Vfqda9q0qXa3AR7VD0e44HT8nvmaDOR78mrNRvMWzpLCWlrH38Q0Qar4ep2SuTVsFNhzo9q0EnR9BnkqkGMBcFUWqqndid3be8gn/Yl3WYYQIhqODSYL3WizkfAHSPKOBGeh/R60CAwKTHvzbN1xxxRkG5NDq2xQ5yAjS4/i8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLZXLkFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67617C4CEC6;
	Thu,  5 Sep 2024 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725530195;
	bh=NMLYodRhAdp6JxgRNb9lmDrOKaJNPSIliyz/0rQ9erE=;
	h=Subject:From:Date:To:From;
	b=VLZXLkFUOcmEPQyboKaHoW3rAKyvMocV4+cnBPtkjmImD/1ilCGiZMjp6y7IUH13U
	 nTxLHLzvIVreSuN7icLV/sTXr3SHnoo5Dxuhdv7cCTuVYCwW37iogiBn+wR9lgZuYV
	 NeSNxTbTEW2lrxUbDEZs0pjg3LPfiwourxUNE/on40FgS+LBYBrs1LIYWqO5aEBPWx
	 zK6kW0xapXq4N+oLLj+AEr/bfzgdDk/x97jWfqdWiyqmUVneXpAO7g1xSYl85/QYWW
	 P5FfjYH/pYnhp2b76LnThxbFC9OjOV1HjptuK2Ta/asBYLzqvXtHUrrRi9nj5NfALO
	 MSrHG5i3oXt0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710773822D30;
	Thu,  5 Sep 2024 09:56:37 +0000 (UTC)
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
 <172553019604.1336618.13628550760490897987.git-patchwork-housekeeping@kernel.org>
Date: Thu, 05 Sep 2024 09:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] fix the flexspi error on imx8ulp (2024-09-05T09:43:34)
  Superseding: [v2] fix the flexspi error on imx8ulp (2024-09-05T01:26:14):
    [v2,1/3] dt-bindings: spi: nxp-fspi: add imx8ulp support
    [v2,2/3] spi: fspi: add support for imx8ulp
    [v2,3/3] arm64: dts: imx8ulp: correct the flexspi compatible string


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


