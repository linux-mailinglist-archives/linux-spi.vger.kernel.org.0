Return-Path: <linux-spi+bounces-1630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 282718707C8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7ACB26712
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C05CDC8;
	Mon,  4 Mar 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq8QR/dV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DEA20
	for <linux-spi@vger.kernel.org>; Mon,  4 Mar 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571385; cv=none; b=f/ppALO/FLi6mktsFIeqS350DAMIMtQOISa86MBgcunpQcNX2Slz9JR2F5mOxY6g/IPSms4xIsmhurajwrRso0cJoHThYdiFIWPq72uOHxI1Hb4yP5QF8ozvmZ/qAUwfzFTRevqM2Z/H+sfdz0igwpVoOCHYu8FQNuRf1GCO82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571385; c=relaxed/simple;
	bh=yTSn0jbU7KDHkQVbMIGwzc0tAjlwoMqwB6sh6EPkJug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FRgiqdhaZTB7aIpiKJMXG/12RaKeMiN7SLURaRJ/OrHz5AjCWtfRgrx7z6GAWrNSy1A073ol+Ry3dfzROi9IVro8dAcEa6/suWws9gdooN5lQlTlUf1tiD4PwkSw69Z685KjmjB6Fqyqas9k0jLknfZ3/ffk+S1o4KS+KGsCY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq8QR/dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C89A2C433C7;
	Mon,  4 Mar 2024 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709571383;
	bh=yTSn0jbU7KDHkQVbMIGwzc0tAjlwoMqwB6sh6EPkJug=;
	h=Subject:From:Date:To:From;
	b=Pq8QR/dVNtgdi1gYXHZcKfUk7z2QCIMn8HSKUA0d5h1et7Wja9hBLqV4b8IdzMsOR
	 FTBJZ2hRk5Cji86cBRzYXNVODFeEjymylFERsP+j+UUsD94gCNlIuir3Fl/x1ckfQX
	 UjE0aGTu39XlaD+We5iNspCDURD1Zr3F/Bou4fyqaIGfq8qYQSZRkkO2iAzdEhWomR
	 t7yCWzd+HGfOihC/ukn19MW6V+XCn1GPArV2SxqtX5zT3DMA2zVr6faR3fWl14xNyI
	 g0qBVQU+LKX+Z+MRrr/l3VKFfwc6dGSzYfHItURtX/QTFZOEfEAl5cHKDweLeAszwO
	 WXVNtjTGdaFHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD8DAD9A4BB;
	Mon,  4 Mar 2024 16:56:23 +0000 (UTC)
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
 <170957138370.28455.17616875089523799977.git-patchwork-housekeeping@kernel.org>
Date: Mon, 04 Mar 2024 16:56:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: axi-spi-engine: small cleanups (2024-03-04T16:04:22)
  Superseding: [v1] spi: axi-spi-engine: small cleanups (2024-03-01T20:25:17):
    [1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
    [2/3] spi: axi-spi-engine: use __counted_by() attribute
    [3/3] spi: axi-spi-engine: use struct_size() macro


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


