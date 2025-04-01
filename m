Return-Path: <linux-spi+bounces-7376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B4A7783B
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 11:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7363A9BD0
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038F1EFFBB;
	Tue,  1 Apr 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oRpVL0rK"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEC1EFFBA
	for <linux-spi@vger.kernel.org>; Tue,  1 Apr 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501415; cv=none; b=afsxKwRTHROEI63JD37I4ky/QTkcAmvkfl98yC7t9SUsEZ6YnvjqL8+PkRPAbGvZLnbCco/JTeZZ4alZKGh5O50YL5r3NWPglfinGqs7FCqB4p+aTAhMZ33nq7M3anhHJuuwPfA5upBKaqiJlaQa64KTZxIyCAqKslNd58DqOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501415; c=relaxed/simple;
	bh=pZiGl+e/GA6Jr4c9d/bVKw71+lyEoi2Q7/dO4CWlYHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1Kr3Nw99aMc1659638iVfHfpJvrMHp9WDngWymaXUIf/KbPDLMv02F38OwK/DqiDoDmDjrFKbSPU+acOF55aq+s0I8aqr2gZ6ZMeX1ypxN5FFJZz3tIp4TfbShoFAFe3WT8QbUGpHmwDJ/Qv0HVsCBicpZs5LyvmpQgcKebLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oRpVL0rK; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0A18443E5;
	Tue,  1 Apr 2025 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743501411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZiGl+e/GA6Jr4c9d/bVKw71+lyEoi2Q7/dO4CWlYHU=;
	b=oRpVL0rKafUn9j7b+yMExIxkEHqZ3Rl0YK43EMWnp/gS10s8j5IkoDQqVMFTc/FK41aXQt
	t9cPq5uGT65c7nT7+WZviZe9giE68wlQ/NeK/6/HPH3wUHLYqDscUpdP/Dh0diw1BOo0rK
	sy+stbBV0OBtGV5tiK9jG6mp//xcf0pJIz0cT9M0tUwR4RrbviTAUXe9FTCPhzTFFO77gl
	3/Ob+sntCp8G0Wz0Otf90vVvyuPWZPAyTK0YAfqrkm6RDrYecI2BGrDR6g99s03xSbAU32
	rf1AhLIZ5PjxmGeapgBCzOta8c0DkmosBhUN734rp61mreOKH5IEojdapue1Qg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,  Vignesh Raghavendra <vigneshr@ti.com>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin
 <stlin2@winbond.com>
Subject: Re: [PATCH] Revert "spi: cadence-qspi: Improve spi memory performance"
In-Reply-To: <01d6ed23-72e4-4c86-8b1e-d7d9fb440c0b@sirena.org.uk> (Mark
	Brown's message of "Mon, 31 Mar 2025 14:24:19 +0100")
References: <20250328173500.3687483-1-miquel.raynal@bootlin.com>
	<01d6ed23-72e4-4c86-8b1e-d7d9fb440c0b@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 01 Apr 2025 11:56:50 +0200
Message-ID: <87ldsktdb1.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrdduuddtrdduleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleefpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mark,

On 31/03/2025 at 14:24:19 +01, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Mar 28, 2025 at 06:35:00PM +0100, Miquel Raynal wrote:
>
>> the probing of the DMA controller has been fixed, and the performances a=
re
>> back to normal, so we can safely revert this commit.
>
>> This reverts commit 6e6363dd2f1e5b3e42505606ea494572c81dbb64.
>
> This commit doesn't appear to exist, you seem to mean cce2200dacd6 (spi:
> cadence-qspi: Improve spi memory performance), I fixed it up for that.

Crap, must have catch the one from my own local tree, thanks for fixing.

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.

I'm curious, maybe this is a semi-automated message, but do you have a
specific style for reverts that deviates from git's?

> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

As per the "This reverts commit <sha>" this is also the standard Git way
to indicate a revert, I kept it as-is.

Thanks,
Miqu=C3=A8l

