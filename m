Return-Path: <linux-spi+bounces-10900-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B70C158AA
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21A1F35503B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC8733FE0A;
	Tue, 28 Oct 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YZlIzKDI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459241FF7D7
	for <linux-spi@vger.kernel.org>; Tue, 28 Oct 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666134; cv=none; b=Baf0IGgW7FDcGYHN386G5zJyunenyw9PFFtLJdaS+TdUXG/CXHHaKEIKyGa6HBviA9y+CKsuLBiGeJ5hrlGj0IRSsN4N8KRiQDNILl0Sx0Bnf//g5PWRqsouxZtc0EbrRrKfVTHpdwU4G9OXfDzGw2kAchxfIOFnZ6ptm2GC0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666134; c=relaxed/simple;
	bh=nmb9otoxS9qo4PpMlQE1HojBqVA53t1oBHFeByRsR9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVGWvY/YkKxy2PAJ+yKwlUKbaVKrZ+0ehEHHKA3zlFTSd158QOMGk+xQZ1mhKEGXPsQsAgxKTGa06RB5Krc4LKrzVoIRDVWG0IL7hQnW/WHgLcRwgx6REx0nT+tinz4MJ3zKpQcG2af8qLavrf5WWhMoz16gisvOGQ8umSMbhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YZlIzKDI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7B7D94E41397;
	Tue, 28 Oct 2025 15:42:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44E7B606AB;
	Tue, 28 Oct 2025 15:42:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5F77117A932D;
	Tue, 28 Oct 2025 16:41:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761666120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nDSVs9lhw+F4YKSYneSSWC5JzdOFTeNiVqf0bisny44=;
	b=YZlIzKDI2uuOlCIyIc2f7SjHrk4BtxyZB5m8F2TanV1WkB0xo4/Bl/0fnuCZqdFFWFLxVJ
	Y6tFo4ygPXXz0LK5Db9RC/r7PvBfOfS2RSB0fJAum4Sh2GIsVUnXLuOy+4TAyEVxUVt0ng
	r8u6miAXNCJKzQLpgWPhQm1TuF9itzKJVfNvcV4H2xhpHGbwbo8zCrSnI4fLpFfQMwDS2M
	f3ub86hwLg7UELL40PKCVuccrdieUDLaE8U6TT/RtNeXBr8DHKDBB8xgk3YbbA7tcLR0Da
	orq83w3vBtzziMwPNeXpYalN6/SxLjEyz5HMqz36hTPft03JfG6n5bdgBMYPMg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <richard@nod.at>,  <vigneshr@ti.com>,  <broonie@kernel.org>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <p-mantena@ti.com>,  <linux-spi@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <a-dutta@ti.com>,  <u-kumar1@ti.com>,  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> (Santhosh Kumar
	K.'s message of "Sat, 20 Sep 2025 23:25:31 +0530")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Oct 2025 16:41:51 +0100
Message-ID: <87qzunt4n4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Santhosh,

On 20/09/2025 at 23:25:31 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello,
>
> On 10/09/25 13:51, Miquel Raynal wrote:
>> On 12/08/2025 at 01:02:10 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>=20
>>> From: Pratyush Yadav <pratyush@kernel.org>
>>>
>>> Some controllers like the Cadence OSPI controller need to perform a
>>> tuning sequence to operate at high data rates. Tuning is needs to happen
>>> once the device is switched to appropriate mode (say 8S-8S-8S or
>>> 8D-8D-8D).
>
> Apologies for the delay in response - I started prototyping new solution
> based on our discussions earlier, which took some additional time.

My turn to apologize for the delay, especially since your feedback is
very complete.

>> This is actually wrong. Tuning is way more generic than that :)
>> If someone wants to use a chip at a high frequency (50MHz in your
>> case,
>> but whatever, there is a threshold above which additional care must be
>> taken), it must go through the calibration step. It does not matter in
>> which mode you are. Calibration would still be relevant in single SDR
>> mode.
>> This 50MHz bothered Mark because it is too Cadence specific. Maybe
>> this
>> should be a controller parameter? If the spi-mem core (or even the spi
>> core, by extensino) sees that the design allows running at XMHz (due to
>> the SPI peripheral properties or simply the absence of any limitation),
>> and if the controller states that it requires an extra tuning step above
>> YMHz (and X > Y), then it launches the calibration.
>>  From a core perspective, I would like the calibration hook to be as
>> simple as possible, because what "calibration" means is highly
>> controller and chip specific.
>
> I understand the concern here.
>
> Let me point out the options for launching the tuning procedure, along
> with the issues in each approach.

Very good summary.

> Option 1: Launch tuning as part of spi_mem_exec_op()
>    - After spi_mem_access_start(), introduce a spi_mem_needs_tuning()
> check (a new callback to SPI MEM controller) to check whether the
> current op requires tuning
>    - If yes, we call spi_mem_execute_tuning()
>         - on success, mark tuning complete in a flag within SPI MEM
> Controller private data
>         - on failure, we attempt a fallback by calling
> spi_mem_adjust_op_freq() and drop to a lower supported frequency
>
> Option 2: Launch tuning within spi_controller->exec_op() implementation
>    - Very similar to option 1, except that the spi_mem_execute_tuning()
> is triggered from within the controller's exec_op() implementation
> (no need for spi_mem_needs_tuning())
>
> Drawbacks in option 1 and 2:
>    - Tuning requires multiple reads of a known pattern, but the flash
> may not always be in a state to allow read commands
>    - No fallback on failures, can't make flash-specific adjustments in
> case of a tuning failure
>    - No access to write_op() to write known pattern temporarily to an
> on-die cache. Pattern needs to be always burnt into the flash
>
>    - Plus, in option 2 - we can't call spi_mem_adjust_op_freq()

Two more significant drawbacks:
- it adds an extra step in the "fast path" -maybe negligible?-
- spi_mem_exec_op()/->exec_op() are called way before being ready for
  calibration.

> While the need for tuning is dictated by Controller specific
> characteristics the ops (and state of the chip) required to complete
> tuning is under the control of spi-mem users (spi-nand/spi-nor).
> So, it's impossible to achieve tuning without the help of spi-mem users.

Sounds like a constraint we can afford indeed, especially since the ops
that can be optimized, are flash specific (relatively few content to
share between spi nor and spi nand).

> So, Option 3: Launch from SPI MEM clients
>                           (mtd/nand/spi or mtd/spi-nor, etc.,)
>    - Once the spi-mem chip is completely enumerated and best read and
> write ops are chosen call spi_mem_needs_tuning(read_op, write_op) as
> a part of .probe()

This looks like a decent place, but there is one limitation to
workaround: picking best read and write ops require knowing what the
controller is capable of in terms of frequency, which means we must in
advance expect to set up calibration or not. I don't think it's a
problem, this is something we know in advance thanks to
eg. spi-max-frequency in the DT, but I still think a controller specific
"maximum frequency without calibration" capability must be carried for
the controller to decide whether this step is needed or not when asked
by the spi mem client.

>    - If tuning is required, call

I guess "tuning being required" is a controller choice, based on the
target frequency for both read/write ops and the controller capability
to achieve this.

> spi_mem_execute_tuning(read_op, write_op)
>         - If only read_op is provided, it implies the tuning pattern is
> pre-flashed to the partition

Interesting. I guess that lives some room for tuning PHYs during writes as
well without more core modifications later, isn't it?

>    - On tuning failure, retry by re-running spi_mem_needs_tuning() with
> the second best set of ops (max throughput - 1)

I would like to challenge this need. Can the same calibration fail if
attempted multiple times (eg. because of the heat?) If yes, then we need
a fallback indeed. Otherwise, I'd be in favor of just failing the
probe. Calibration is an opt-in -> users must allow a higher frequency
than they use to in order to enable the feature?

> With option 3, spi_mem users are limited to calling
> spi_mem_needs_tuning() and spi_mem_execute_tuning().

I would even go for a single spi_mem_tune_phy()? Or is there a point in
having two helpers?

> Rest is hidden
> within the controller drivers. If spi-mem users change read/write ops,
> the above sequence can be re-issued.

I don't have use cases for that in mind, but why not.

> The controller can store the read_op and write_op in case of a tuning
> success and periodically re-run tuning, ensuring we always have valid
> tuning parameters.

You'll have to make sure you only use PHY calibration for the ops that
have been used for the tuning though, because for example as I am
working on octal DDR support: during S2RAM there may be the need for
returning to SDR mode, which in turns will have to work without the
tuning (tuning parameters will be incorrect for this mode for the time
we run slowly). So either the controller knows which operation should
enable PHY optimizations, or we must perform the whole calibration again
every time we suspend (meh).

> One concern with option 3 is that we may not be able to make use of
> static data on certain flash as tuning patterns (like reading parameter
> page or SFDP table for tuning instead of controller specific attack
> patterns).

This is true, I know some devices can send patterns during dummy cycles
by I have no idea how powerful that is, nor if it can actually be used
in Linux. One need a controller that is aware of these bits and can
itself adjust/fine tune its own configuration. For now, I propose to let
this aside until we get real hardware that can be tested.

> Please let me know your thoughts on which of these directions makes the
> most sense.

Let's got for option 3. I'm eager to see this moving forward!

Thanks, Miqu=C3=A8l

