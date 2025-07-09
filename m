Return-Path: <linux-spi+bounces-9075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D4AFDDC1
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 04:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C823A4A3F
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455C1DE8BE;
	Wed,  9 Jul 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBEI66dT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0891187346
	for <linux-spi@vger.kernel.org>; Wed,  9 Jul 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029925; cv=none; b=nH3eYTo8RRaG44NZGGslAm/0lPplwSLQBGZ+xELbwOayRnkqvbfTLajA4jW6cY373r8lg5b/OTGXNN8r+au8BxtfPxm7xyG+TMN9g77+7bpDntGJSOLnt4PtvC2S/+aSwyQhtwexH1wswCWrdYgLlzKb1sO5myDO6SBeQM8k5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029925; c=relaxed/simple;
	bh=plPP9ZP19kH5lsklgOOctbi5rex0t9l+AwswF+Zjbmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GbY8sf586pf9eii0bm1x40uH2RK2khejRMa3tUug3YBaFuiw6mjjffyDmAJ+Dh9ciu4UpnpyJqhWthpTjZhDMULapHxrxOHGejrRlZBhfjfIAlCHP4Ba5PjE2xqj7P3Fe3mfHLfaFe3hfyov0G7Ox+c71I3+cTabekJW4ByyZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBEI66dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C905C4CEED;
	Wed,  9 Jul 2025 02:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752029924;
	bh=plPP9ZP19kH5lsklgOOctbi5rex0t9l+AwswF+Zjbmo=;
	h=Subject:From:Date:To:From;
	b=TBEI66dTB+IMZpSJUEh1fM0jDCbgn/sInEqW+iItLoRGnOu00qG+1xpi6/fgKXI56
	 Ez10aCMDqr6OYVi38150HV9m2nCf5aFiv3QYBFvrhmDX2nYtLbK0EwELfLWAQ9D7fk
	 2qj2+IdXzyHmqyrZ2BgcuKAOJRmy+Jel4hnp2hgdJ+MFwSoaxgBoscyHB083opHIyx
	 TGqwJdnZlkGmJIOIWwCLWRBKIVtoAMCEQjSb55WHh7bTJKA/rYopTEEAz7zzU8Hb/d
	 MuQHgveQPaph1JJHus7F6dVDNLH9ZSQGUWCP/V7HkVYbplC/qpZVegjo+2v1IeXTVt
	 M8x3MdkH82fMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37417380DBEE;
	Wed,  9 Jul 2025 02:59:08 +0000 (UTC)
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
 <175202994662.204247.14416974024045451235.git-patchwork-housekeeping@kernel.org>
Date: Wed, 09 Jul 2025 02:59:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region" (2025-07-09T02:16:37)
  Superseding: [v1] spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region" (2025-07-03T18:35:37):
    spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


