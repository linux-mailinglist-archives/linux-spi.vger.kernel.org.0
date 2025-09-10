Return-Path: <linux-spi+bounces-9961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C62B5110B
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0508A3B754E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822430E0FA;
	Wed, 10 Sep 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dh6Tt8QA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90C30E0D1
	for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492510; cv=none; b=KEGeD5yoU9ez4qR7LOH3gCEPzTcp2X81VQh9mrpKklCWSgKZy6qDyaUYtUf/aSzgL+CN67v88tMHkCGO15kittu0C6wO9BrDokxWRFQWwjjdenOQfl2AbxqzL7BmlLeHkmv55d/dw+Fg+u4Kgv187bpJg6qdkd+ue5PX38gorHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492510; c=relaxed/simple;
	bh=NbAiRonudTxxn0Dt83kCP93jhH7iA1DD1uK9tgWHiiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWhbol8TrEhop0SMMqjYHAvmwwlD7cY+zftSWhadUN0V3YG74+u2miJghqBajasT2V/my68E/JW8Xbng2aNDXli0dLjj9nNlX6tgiaK8sCvgmVFxL0BRuE5V7oPS/qXxACYrWnw5ds6SB7pbubZGBkB2CyUqtY3aWFBK5azZpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dh6Tt8QA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 10DAFC8F1D2;
	Wed, 10 Sep 2025 08:21:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9BDC606D4;
	Wed, 10 Sep 2025 08:21:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA2B7102F23C1;
	Wed, 10 Sep 2025 10:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757492505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NbAiRonudTxxn0Dt83kCP93jhH7iA1DD1uK9tgWHiiQ=;
	b=Dh6Tt8QA6S70Ghz0oNTxymUWY03z5vFwvRqdDkV12ToYE0rTRT08QfmezeuxMoIEqzcWl/
	cEOByp9wkD/cwK1RWAGKqg/P3BdtUSIQFagOXeU7fr9kzHduCLwk0zrMbqdmYsThRS5iom
	vImynl8vkdYhu/jfi2lxvheeX46HtQ/5oKVKcLPZEC/iZbrlWi2YL1fKtcBBg2ryP1j/x8
	05abcsmYL9k/3QBYaPhJ1Lsy+ZPq8aWpT7E1Oj0SPFKLP1B/DneTM8LkIniHVRlC3dNaB9
	9JI4nf1d989RLkND0p9cHN/YkDpXNvu3lTyIEMxadnItlTGBThb01P+5SRg7Sg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <richard@nod.at>,  <vigneshr@ti.com>,  <broonie@kernel.org>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <p-mantena@ti.com>,  <linux-spi@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <a-dutta@ti.com>,  <u-kumar1@ti.com>,  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <20250811193219.731851-2-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Tue, 12 Aug 2025 01:02:10 +0530")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 10:21:41 +0200
Message-ID: <87seguemzu.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 12/08/2025 at 01:02:10 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> From: Pratyush Yadav <pratyush@kernel.org>
>
> Some controllers like the Cadence OSPI controller need to perform a
> tuning sequence to operate at high data rates. Tuning is needs to happen
> once the device is switched to appropriate mode (say 8S-8S-8S or
> 8D-8D-8D).

This is actually wrong. Tuning is way more generic than that :)

If someone wants to use a chip at a high frequency (50MHz in your case,
but whatever, there is a threshold above which additional care must be
taken), it must go through the calibration step. It does not matter in
which mode you are. Calibration would still be relevant in single SDR
mode.


This 50MHz bothered Mark because it is too Cadence specific. Maybe this
should be a controller parameter? If the spi-mem core (or even the spi
core, by extensino) sees that the design allows running at XMHz (due to
the SPI peripheral properties or simply the absence of any limitation),
and if the controller states that it requires an extra tuning step above
YMHz (and X > Y), then it launches the calibration.

From a core perspective, I would like the calibration hook to be as
simple as possible, because what "calibration" means is highly
controller and chip specific.

The Cadence SPI controller driver could request the pattern through
the nvmem interface or maybe we can even include it in the kernel
through some type of firmware interface (it could be stored anywhere)
and if it gets it, it writes it to the device cache. Once done, it takes
the fastest available read operation available for the chip and performs
its calibration.

The calibration hook no longer needs anything SPI driver specific. I
don't know if still requires anything chip specific though (like the
optimal read operation), but can you please try implementing that and
then we'll discuss this further.

Thanks,
Miqu=C3=A8l

