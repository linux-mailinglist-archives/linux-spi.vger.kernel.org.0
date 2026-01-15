Return-Path: <linux-spi+bounces-12423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F41D28343
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37149300F5BF
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46F2D47F4;
	Thu, 15 Jan 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b="fWvxWKUi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482FE312807
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506150; cv=pass; b=ci0BlCmsnjFF1Op7OC9aYvrnrDJwJ6BX7NY8BNPtgevKGMuw1sLZOvllHpZGNgr3cZR0SzOWXv0Met0i5mDBIu1h2Qu8LjJ18bQW9RfnSzhnI/n9iLdLTqpkharQEXrd9A0+SfnL3TlTZYxULulcGO0eI3SBe+PRUdXPeIsTlzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506150; c=relaxed/simple;
	bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UqdwiL1LbQG6WL97XosTZNNDTsDLPvyG8q+jf/FQBf1gWpl9nS97feBwPb9OkbcUV+4bjWsIGYAwKq1DSTnc7veZUHEhIKTv/KY/qlWHPIkvPq5vG4sUsWZpxB4PL/emKzh0vRn8uU7lEuqFf/NiNjcFmIz78JxiWMyVUZ/8KC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org; spf=pass smtp.mailfrom=oasis-open.org; dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b=fWvxWKUi; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oasis-open.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so8963866d6.2
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768506148; cv=none;
        d=google.com; s=arc-20240605;
        b=UXWQB2kfPG/WE023i3UbzC2hfDO83s8m7xP6mx2cF14TSwNw2YC9dhZoxQMvZPljfj
         L0hh8wpm3GS+mm6oqzpdyTZMRppNF8fsvmxwv41XSoZCqAioAntkhIr17mq3ysL6YFnR
         hoUnzgbljohKMQ92Qz8tdavPIIX8pzhuL50NmnIZSYNjbgcQBHI/9pnxUIKJbhugBMfm
         5QStMOeKkDXIZMkNR2UNTuNRza9NpVrTpwoD7yYjvm7Qx1IXT0Sj7H+lytx5e16azW2V
         pfPTVpDZhJYiYjGVLJaAAo1L92d8pizGdy+f211kxakCertt1J8YiX3XEsqXIk+7QhYO
         xsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        fh=/I5cyZnMiAN9eGeOh/ODxLiC6HTDV4NXVCL2a0ZKgRw=;
        b=hE0Xuci6tSoJRxjWvM3asTW6jWN4PdqRSoR5acbb0r93XvZ1j5FcTvZf+RMqW4EvUf
         Ud1Gv4fkkwJijHNBVJOW6rVcqdXkTT84BYh8SgCYbvb49wgBlwtaBd4PA3xb81doJZM/
         Cf403mIq1tGO+jph14HttgttH9RDxeEni2ggBX8HVt5sxJ2UC1GS+O4GQVY6z2++x7nQ
         KgPnGnSVdeR9m9EfFGYmldCtIb/C4V5vf3aRoy2LXnkThZPUQb9PD4pJWKIMfOFmOkqn
         61KR+rAEtNSWyoZrEhhaL3ouenQ64jXvTEulaBFgmQN5Uw8sbQLJtS33Uh70X2WrZuxB
         iBUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oasis-open-org.20230601.gappssmtp.com; s=20230601; t=1768506148; x=1769110948; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=fWvxWKUiSEoOCihR/RgG3uKt50NjIzjpwyP6vT48WfhC3/qtVy+kdFzw9gq1AFEOow
         Vwuhl5eBd2PQKF5gex1j5U1iotcFZJSgwSZkkUNDaCvDwbuIh+BM5JhUPqqh3Tvcqxkj
         jwpS0VZe0YWHdFxKMTPKi8Ue2Mg9LCO75LbcQ/AiEjN4XY8/Aqjy5Xot18BAniyNEooQ
         56o4mAIUa+bpyfGEdIhpwQZSJ2Z9BPCGU3CU6Mx5yIHRJwSuh6oGjCxr9s+SbSuSMN2w
         uUJW3tDQTyANH+E0YVJZiV0nLyiWeglLY34eSdZmKKx0P6lPLNz9mCpxQoOwMzZ+Ljeb
         up9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768506148; x=1769110948;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=sfvNYBk72ghV6yMyRfNwyZqjvaHC3JAh2nFVh/+rt7mqjjud7rP/NS2RZParfshfTo
         EA1W6TdEsxYpjV/PDTS926oCQDgZQxe4jVSagGIY5fvXwWLQJNlunVrv9R6PO6xcN5Zc
         i1vNMFrGT+3sd/YHsTzlZ+1on3PlY4UFEj91LrPdd6JuuQuHIwrCkvuQ3kTae4Sen+xM
         S/nRgOLlM2/cf1wClpVcU5w+/qYWYi/jEpWz4t2DH3WwOqWpr6xQrNpZ7cI4JW5ttJh1
         Ma9qR7GcwJNsPE8RF/w+hj46PRagjA/oRnEUHVpGD5Zyw3t98gcpxxB1I4OnckrnucTB
         eYpw==
X-Gm-Message-State: AOJu0YzSOG5frzHg3OIU53x2+DywUAKj4M2AazdJEbHpl2qzAybh7bqt
	3ZEQUWbyDcHeOCRoq6Qnu3ztLi+q2z8v8+mSnhl8kJtcJGBoUZ71VratQNbGUemKQtDRi3ayHPI
	FkVXmSqofe1XeUNI4FAxN3XKZYWcF0kRtucv3R7cnGEa7pLbQdnGz5pY=
X-Gm-Gg: AY/fxX5RXotvfPkSEOEcBXgrh69+/yB8hL5XY+gUoSSiAO0lHufrGyejatbLlul2NdW
	ZG6vYzWVP0HkHquVQByuWv6M55TxNT/ZwY7CV7dQFx9KtT6FqyUI48La4+VplPhncXhxP+36RsN
	Htr7mGmIC3Q/NypJayVjh3qVScMB3yFvWViSiOua0kTL06n6GWLdsKvbzW4uc7JL3IBJpDCh27G
	ZN6Ckege1qfZSFXX7kPDXtZFH0UqHZch2ROgZYvlXLIHjnTi69ShKduT3DP3/wSyNxc7dHYe+od
	+Bq44U6StTrYA+nlwfouZ1osCRvUfns1U1oyix32UyjYvvlQwerRVI+j+5gg
X-Received: by 2002:a05:6214:5283:b0:88a:2b3c:463c with SMTP id
 6a1803df08f44-8942dd70194mr8833856d6.37.1768506147847; Thu, 15 Jan 2026
 11:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kelly Cullinane <kelly.cullinane@oasis-open.org>
Date: Thu, 15 Jan 2026 14:41:52 -0500
X-Gm-Features: AZwV_QjcZuyMKSSDUn7zRJIv7vrdi-ai1fqKtEfZP9BwphHLy_zH5Ty4eemy2zE
Message-ID: <CAAiF6036Z25evk=m7aKd2n5mDkcFz5rqtdA9Kz2uOSXzN66Ltg@mail.gmail.com>
Subject: Invitation to comment on VIRTIO v1.4 CSD01
To: linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OASIS members and other interested parties,

OASIS and the VIRTIO TC are pleased to announce that VIRTIO v1.4 CSD01
is now available for public review and comment.

VIRTIO TC aims to enhance the performance of virtual devices by
standardizing key features of the VIRTIO (Virtual I/O) Device
Specification.

Virtual I/O Device (VIRTIO) Version 1.4
Committee Specification Draft 01 / Public Review Draft 01
09 December 2025

TEX: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.html
(Authoritative)
HTML: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01.html
PDF: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.pdf

The ZIP containing the complete files of this release is found in the direc=
tory:
https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01.=
zip

How to Provide Feedback
OASIS and the VIRTIO TC value your feedback. We solicit input from
developers, users and others, whether OASIS members or not, for the
sake of improving the interoperability and quality of its technical
work.

The public review is now open and ends Friday, February 13 2026 at 23:59 UT=
C.

Comments may be submitted to the project=E2=80=99s comment mailing list at
virtio-comment@lists.linux.dev. You can subscribe to the list by
sending an email to
virtio-comment+subscribe@lists.linux.dev.

All comments submitted to OASIS are subject to the OASIS Feedback
License, which ensures that the feedback you provide carries the same
obligations at least as the obligations of the TC members. In
connection with this public review, we call your attention to the
OASIS IPR Policy applicable especially to the work of this technical
committee. All members of the TC should be familiar with this
document, which may create obligations regarding the disclosure and
availability of a member's patent, copyright, trademark and license
rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose
these if they may be essential to the implementation of the above
specification, so that notice of them may be posted to the notice page
for this TC's work.

Additional information about the specification and the VIRTIO TC can
be found at the TC=E2=80=99s public homepage.

