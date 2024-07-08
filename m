Return-Path: <linux-spi+bounces-3788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC892A689
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CBD1C20DA3
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D11448C8;
	Mon,  8 Jul 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx2gRyew"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4EE143896
	for <linux-spi@vger.kernel.org>; Mon,  8 Jul 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454176; cv=none; b=uTMQE5r/doLO8KtXy5YIa+usTFbbnP1coiaat32jHTPxxUkD6MxtDwXG+s1KwAdZLHbTVjirfkyx2XdDYmxG7W5P36v4Fl/sZDyiu9dI/8OqOB1fXMLpxthyJXf9B4z6XKPk0hVoOZDV5ioKRW4gdm7aYjjNy7MQPT/tvA5sxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454176; c=relaxed/simple;
	bh=SL291pIJZ6rbMAdJriWRy7vJuzOxjqXSKu0wUkp4ab4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MQiOIApjnjOlVYf81v2b86BeX/3iJ1mDl+SNhrvj3LC/j1IKMhrcfTa39wFZJG2PRNUJ5h1V6hBMDxBrQHznn1g3HQytOcGWf3kovufUO8yMckXCW1OSXw+d3Jx2g25S1jzyczxkQttxXB5CDf4VojVQgb+GFFrp+u+kKVn+HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx2gRyew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F8DC116B1;
	Mon,  8 Jul 2024 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454175;
	bh=SL291pIJZ6rbMAdJriWRy7vJuzOxjqXSKu0wUkp4ab4=;
	h=Subject:From:Date:To:From;
	b=Yx2gRyewKVKLIne2X/hKQr8RhGcnaQ+iecIbLLyQ64kFdTRfL5W2igSQJqRiKoYWi
	 EILattWXB9vlE5UBn8YJjOKzQG3AvUJxK4rzrvEStNtkOXJDaxnTED5ojZ12Mdc9FM
	 3oRvoOaoXZMeL9XXBAbINYLMMYGiGyNaTh+o4GMLmW2BgK/OehmY/3DMiaPzi/irhD
	 KkXRdYv7gyKi3/DFR8sExPh1Yy+el7ma2HaNWlbIrCC5mOHQRVUHEN04ulUaamI0GD
	 PbXpyw3s2TkkFsQ7TruE0LJl/Ao2TYrgygUk96oDbTezauxrh4TMivXGNniLJvjoXV
	 JB6kVGf2QhUnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DF0EC433E9;
	Mon,  8 Jul 2024 15:56:15 +0000 (UTC)
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
 <172045417555.17157.17243853120930298179.git-patchwork-housekeeping@kernel.org>
Date: Mon, 08 Jul 2024 15:56:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: add ch341a usb2spi driver (2024-07-08T15:49:28)
  Superseding: [v2] spi: add ch341a usb2spi driver (2024-07-08T12:38:56):
    [v2] spi: add ch341a usb2spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


