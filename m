Return-Path: <linux-spi+bounces-7124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2607A5F920
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5263B5AA1
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFD268685;
	Thu, 13 Mar 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp/jk3zM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F762241C8B
	for <linux-spi@vger.kernel.org>; Thu, 13 Mar 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877759; cv=none; b=boi9+h/+wPV8Bs2We6xeG0vy6Rk3tQWDsWes2kxNBpER8nop3FQdQYT4AobO+2HWs+4gnxz1nQkjrJK4gmoF/SqbSw6D9zoZ9Zd40DXNCWaXTMahdEpTTzRJ1E0ESxLyLYe7NQcTuj7ajFLGanV6BQ0kn88Q7vu2XA4tfecWDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877759; c=relaxed/simple;
	bh=1AHZYmql6fTU57klG+IC8T51av58jdlOiqdifkMQclM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KMKnEzHyotHr6yJKoN/xkfv7NNgD0KaZ3sM+KjRDc9fPo3DFL0mUcYYXTAxyjli114PqInR04St6UDkKYD/A/uyPocIm4ad33ym7G6eHfpgohdDqfw9ZYWIj4hIyX3dCJs0WaCplxLWHvK0QBI9BT9zjb6NRE+tjl8QmskHz3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp/jk3zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED288C4CEDD;
	Thu, 13 Mar 2025 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741877759;
	bh=1AHZYmql6fTU57klG+IC8T51av58jdlOiqdifkMQclM=;
	h=Subject:From:Date:To:From;
	b=Mp/jk3zM4KgnaF5rof0/0jFrTK/u2Wfr7z4+qwPbVBD0Uw5dtcQ6OAKGOMDzlr9Ue
	 9EqVlVNXJsEtVX77aCdjmZIF7UGoP3AEyb+guFNgT17bhEQgi2/NWI78CexnRd5StL
	 vhXS5xPTBNw393aC4aauWQYdI/erUSqGFwQR+SbSc1EzsaFVHbXk+vh3+nTtFgbgSA
	 MEExSwcdKb/ANnDH9zpc6Vg7vGpaoIXf+6Yo1pd+Xow/BxB/iRnIdfweMmij1ftuDn
	 BXYqpT/aJ3zAWrRLMU4IVTYC9wd0z5tGApppEtfkqOFpNzWm3VI3VgTFIgn0qILV0P
	 lIKfrs8ZnJdiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCD3806647;
	Thu, 13 Mar 2025 14:56:34 +0000 (UTC)
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
 <174187779337.1544138.14373563515006856811.git-patchwork-housekeeping@kernel.org>
Date: Thu, 13 Mar 2025 14:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Use inclusive language (2025-03-13T14:03:13)
  Superseding: [v1] spi: Use inclusive language (2025-03-13T11:14:42):
    [v1,1/1] spi: Use inclusive language


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


