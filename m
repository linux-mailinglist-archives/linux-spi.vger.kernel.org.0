Return-Path: <linux-spi+bounces-8994-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B6AF1648
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 14:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CF816D974
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306827511E;
	Wed,  2 Jul 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RURpWl2C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C92275115
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461173; cv=none; b=YVrW08YxVGG6h/x7z+gUT/4/TsGLGVbPTWR7GMA/sr2ltZ2otDXUPOVfYcYxFZ/zcySy+2Y6CsTTLm/rXkeM78uAX0asc9TP1tsIn403I1TUgPIy8KWrdod6blwO8SHeSYoZ0XTp+UDP903B42NnzmEV2Pyqhp4bspf+4/vuPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461173; c=relaxed/simple;
	bh=BRgEY22rRhnp+0E/44Kag0QV0BWpLHR2geUwzt9VF+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hvXFvvZdLzzTAX7ewu/EJQnmG+VKsuZQ+q6HfSNRc4lXdSMY4zn8d6WEoRA+kVqTBlBgh8G61X+9CAMI3L2hWyHG30OL5O7bWePwFarfZ1fgOkTTA3NbTfk+Fk3/yCkHJRIfJrjB6IJFgn5fYTNbjq+3ICFz9gjFfNEZ1wp6cb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RURpWl2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9C6C4CEED;
	Wed,  2 Jul 2025 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751461173;
	bh=BRgEY22rRhnp+0E/44Kag0QV0BWpLHR2geUwzt9VF+k=;
	h=Subject:From:Date:To:From;
	b=RURpWl2CtKoNKozGu2hlkdJAFkqDrvjLxNS9pOm48SrB1u+LJIhvG0wAFzfwutOPN
	 GUs4hDY/5MgpBTU7kABoxH0xooljvPKUjpsCVcMVpa4OrCdTbbY/5j+2FGiMDnr+jL
	 dCA+IEfroze0kejwkjsxbyvIm2GZFgBlD//gDDM3lssmJD8tfN9ddd1athkbmsa8RR
	 ap1JbEiMQXogbOrDGGJ5yg48E/HCHY1aXBqT2xMzrCu5oUlDVEbxA+rE64li1FeULy
	 HtEckrUkyu05ByNbF49uGSVDvYKTFrnFSEd+YoZWmTS6wGLWsRESC00zvfKVhn53M9
	 1F1XfjGC+4W3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD5383B273;
	Wed,  2 Jul 2025 12:59:59 +0000 (UTC)
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
 <175146119784.707088.17417359078489658259.git-patchwork-housekeeping@kernel.org>
Date: Wed, 02 Jul 2025 12:59:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-qpic-snand: enable 8 bits ECC strength support (2025-07-02T12:35:22)
  Superseding: [v1] spi: spi-qpic-snand: enable 8 bits ECC strength support (2025-05-02T19:31:15):
    [next,1/2] mtd: nand: qpic-common: add defines for ECC_MODE values
    [next,2/2] spi: spi-qpic-snand: add support for 8 bits ECC strength


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


