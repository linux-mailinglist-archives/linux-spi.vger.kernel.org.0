Return-Path: <linux-spi+bounces-7000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816CA4D1D7
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 03:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA19189310B
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4515ADA6;
	Tue,  4 Mar 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaTLWrmQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BB6EB7C
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741056965; cv=none; b=Rp+Z/v44KirXOF2xxggvTRwaFVtLMtVOVTfywvgn122/hhqlvUgFpruUkk4lHCM9vLLfsS8gY/69DI5qxiQisugkdq/63G58ZrjG8PUIuiqvFxQcQlPp+m5WKdjYWPxMMf62m8uLWXYdBGx0fiRRlVE5rwxJUVw6URmD8LqbOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741056965; c=relaxed/simple;
	bh=kweTu2q3bh/7wWD1fJ56UJozFcsUQWKFAv0qNNXHVck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=prKz0TU6uGSnDShfTCf7iM9rmCIRIPLCEOhB7vsek5mYotUStryOpmgc6w/dUfQ040vC5RnFt9Pe3koMbPtMvt9oqipWFriejbQqETH+aPCu43/9H5LUGRis0HUSOWpVkHYpZizptaF9l240hsXmVxxDLKzVd/bWZfGmOHZcFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaTLWrmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77444C4CEE4;
	Tue,  4 Mar 2025 02:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741056964;
	bh=kweTu2q3bh/7wWD1fJ56UJozFcsUQWKFAv0qNNXHVck=;
	h=Subject:From:Date:To:From;
	b=UaTLWrmQyknK9P5hVT1XD40fV96ZdHW2S37L5epdcipjofr6MrbmsQVSbxW1cZeYg
	 LS/zqJhFrkkh/p8fQ2FU8zd1xyOfa6DX2571GD/2m0pTGIrBh7SGsqYtjTbDGMR3av
	 ag8FCf1lG1pr3mALOQNWXLFEsTDIfFbKQdEKJ2fe+pq+VK7/NoA6DuylQmIAlbDUzS
	 nS/wR7bQyo9KEm4LqkPYqPX4jfgp8cMX1dgAu1laUzsVF/x4dGxzxZKrpyJDWDDSvD
	 UE1s9Vux2wwnTmcGrHqo8d+kl8I7CH2LozElQhuFetOJ3I4IgtGRVBq4sXJrijGX5K
	 Do+AaQe3B+IoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE1380AA7F;
	Tue,  4 Mar 2025 02:56:38 +0000 (UTC)
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
 <174105699709.3844687.5505923821486606166.git-patchwork-housekeeping@kernel.org>
Date: Tue, 04 Mar 2025 02:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: mt65xx: add PM QoS support (2025-03-04T02:37:15)
  Superseding: [v1] spi: mt65xx: add PM QoS support (2025-02-28T06:22:03):
    [v1] spi: mt65xx: add PM QoS support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


