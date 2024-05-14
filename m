Return-Path: <linux-spi+bounces-2839-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F58C4D67
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F1A283ED0
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C217577;
	Tue, 14 May 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpGkom8Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080E125A9
	for <linux-spi@vger.kernel.org>; Tue, 14 May 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673479; cv=none; b=OBp/33xg0ES6y7mhGUeAq+T+WM5m/Sbp9xsRc25TykfMSr7QXyTLENFcKY0k5rRWFPOqftwP0BIGvVhx/DewFBVhXEoKke/cXn/nFK8xSHtYN28TW+QPNt5SxiOK4B5Jm3aCdd/EIZs50d1khqsz0EiTGnfPP5uTn6aQdnGaHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673479; c=relaxed/simple;
	bh=AzPlAbzv0s2iBDGWl5vzLzJBzsRgW9dSH1RIv668m6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=n3H7Tu/ZnfdR6ohDVbwf+S7MA2CXERIp0AoJJhLFSeA+ZnQfgU7XFmKt5ZHd/X2LxUsa7qI6rCNMcAMinV/dzeQksFCKPX7ntxf/5CAABV86lE57uP3DGSSVseT71Vwo5UTnaZBEbwWyfmvPVrzI/nNonuIG5QTGvdbLlpPVlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpGkom8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0AB4C2BD11;
	Tue, 14 May 2024 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715673478;
	bh=AzPlAbzv0s2iBDGWl5vzLzJBzsRgW9dSH1RIv668m6A=;
	h=Subject:From:Date:To:From;
	b=cpGkom8QO1SpD1u2W2WIBWLOLUFuXa5CQDjty0w8/b1R7DlQiZbnpDkxI02Qd6rE7
	 IkwR6ZiNozulxdW7XkUiCelngB8kb0Hs28/+w3krs6JWJEhUq8wSgzsAQqDCsEjej9
	 MLQZGYhX7Yq1J6m7m7eKSz7hBLbpj2JDH1xZtrBoWGx+ioAfJKU2KpJBJaB4Bf8QA5
	 1j/hR1OX0FiUCWIp5s56pDkbK+TUsuEvfRTSyQFHt+h5C2dj0PBKnZVa0NYu6ebpdl
	 tK1vIBLwb3JqYyvLFNAtgAgj+k9dFiDCynHhM+pemJrLbfRD4iJRdRba6znrB50uPp
	 4fSSt4HgipN1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8311C43332;
	Tue, 14 May 2024 07:57:58 +0000 (UTC)
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
 <171567347874.706.1895938342087989077.git-patchwork-housekeeping@kernel.org>
Date: Tue, 14 May 2024 07:57:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-14T07:00:47)
  Superseding: [v2] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-11T06:14:56):
    [v2] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


