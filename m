Return-Path: <linux-spi+bounces-2007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5CD88C2B3
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 13:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F101F63EDA
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91456D1AB;
	Tue, 26 Mar 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue2Q+PCx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9A5C8FF
	for <linux-spi@vger.kernel.org>; Tue, 26 Mar 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457811; cv=none; b=j7aD5JIlr09W1k3LnzFLk/erSeIswlZJt4yeacp4zDmz4w2Ysd29NqrR9Vo2DVLBVMghs0dMTWsZu5cjw3eil6kIAWVXHpW0LlWeDJRZ26yd0i91Wzj1KkPySonO3kyN5V3lX4JOiEEV9RJRpqRJdBQ6VxV7qV0gzv7QRqP8Ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457811; c=relaxed/simple;
	bh=iIGcTGBwXKiKNLddmFH+2ZdW2gwN8eDN/rOdQBJW1EI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ByYkNpxsgbCfWJBUkgmpLCxfFuQjlxHBoOm4rPV6cnHAH3G6IPO1vOGYfoAagsm/TQwDLSBhzaDeSo6r1N/Mpr9Q/cP+daAL8l04grIYKDynBgJXgOGEBX3SmRJF3lZXoExZ0zvJ/2t+iTUIPBcCQen86a0oR3QZdVgw+JR5b10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue2Q+PCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29BC2C433C7;
	Tue, 26 Mar 2024 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711457811;
	bh=iIGcTGBwXKiKNLddmFH+2ZdW2gwN8eDN/rOdQBJW1EI=;
	h=Subject:From:Date:To:From;
	b=Ue2Q+PCxt1qR1CaHiTNJmTBQyqYrhXBnVz0vStSfTF2aOS/mpspwcZhEczgo7VKbB
	 kjTVUPPQcktme9CH1OPgNhXimY+X3NNVyNfvPO9IPHCR10UBtWqE882ujGrd9Bu7mJ
	 BFocR6u+coYidXVhLihrk8YMQrwT4pLzA34rp2e6cRkIAXOovhsMS8gmSEGkfRDOpV
	 XlKX7KXombZw5C7657+jGjDglBc3vCAY8WilXpyCewjR6a+cm+blKSF08cqaa/DGwp
	 b0Z5CHJeNA0W1NlW+UccyuhWyQfpF71nM8qrRc22OeOBjzIlhJF1Avgzgq3ax6cT/d
	 XL1dYu5yeiJpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16CBFD2D0E9;
	Tue, 26 Mar 2024 12:56:51 +0000 (UTC)
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
 <171145781108.21456.7375763698011631352.git-patchwork-housekeeping@kernel.org>
Date: Tue, 26 Mar 2024 12:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Virtio SPI Linux driver (2024-03-26T11:28:11)
  Superseding: [v2] Virtio SPI Linux driver (2024-03-04T15:43:41):
    [v2,1/3] virtio: Add ID for virtio SPI.
    [v2,2/3] virtio-spi: Add virtio-spi.h.
    [v2,3/3] virtio-spi: Add virtio SPI driver.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


