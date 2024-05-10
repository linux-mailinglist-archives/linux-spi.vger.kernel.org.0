Return-Path: <linux-spi+bounces-2810-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9AF8C2A5B
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596492864FB
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B8EAC0;
	Fri, 10 May 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvydJ7Sg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02251446A2;
	Fri, 10 May 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368204; cv=none; b=ERyexcGFMeuqUG5RcQYiGKdwkIN5eMJl8qQ4iIxvFOc6wTqwFO1J92ebwhMYivIy2e+EfPLpX58rLsIgMsJcSbwNC5Tk76gSuPQ2iaAGUql/NieRdadAOCCW0dcMcRrBWpfoPRO8EQ/8HOP1URkF7jU2JRmAd1HWIY07TehYOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368204; c=relaxed/simple;
	bh=DIJ0WHV6ZUBw+5ZA71iAYdpvZWGtbxrBxN4GoBr2w+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MNqF+XNymfHYyrEusg9dvFlkjSN0Vx7nDfUZuGCDrcMqKOeiSuosEeBFLHFZY2S5p9Wr+Nc1rXZ3Cz5k4UKZp8EVnGeBKA9bE7ZYV3E+2KY4cFL+oKhLNgAtsrsH+aiur12177UIDdiQRzd6fqH5uyKrI03xO5Pfaq3H79HVNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvydJ7Sg; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23f29434da2so1464229fac.3;
        Fri, 10 May 2024 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715368202; x=1715973002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIJ0WHV6ZUBw+5ZA71iAYdpvZWGtbxrBxN4GoBr2w+I=;
        b=NvydJ7SgPYpaZkNeAATn2GSD9NTR5p28upThnlKIUVb7wqYfM7y8rfb898MEsbL6vM
         do7Az72nt5wLdP9mkgQxpyPvWeDPs9RgtqBfbxeDTJzFMq9aVIFmwYgPIyrOegMbhuLc
         5/Jgd6YSH+32udned71Mx0wxz9OpD/huVx0LJprgNpz+F1gzxX/Wk8cnwFZblkwN9lxH
         08MZ9g1znYFAm2NJj2poBEpPTEd4Bfm60tCNjrgSqKLHZSOqbtuxDzfIAyHBE3yDyMz9
         UTxgASKBliuckDWDAE2yHXzQIgf6K5FydgtQP9s27CpmflJ/CYBEaO05U5sLhZ14vteY
         PWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368202; x=1715973002;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIJ0WHV6ZUBw+5ZA71iAYdpvZWGtbxrBxN4GoBr2w+I=;
        b=QdB/X3xGAVVKVR3A4nfRXbznT/aKcj0NZrDnwEEDbdQGpK0jbisKHVKULVetnoDkzH
         uLfeyS5zC0rKty5LMGrikQkDx1iul1vSGvffFNrLSoW4RGsC7RHydZGQiPjIr2W5SnoV
         wyXNxHEScly2DlRf4DWjaOrAXTjSJ/E8g/j9D40Y4VNn7e/WXXJpTT7cwFzWrLXCEjLN
         bHEeULjK8Zd+0y2N9Aj5ogJ42I1qTO0/3XBzCc9vCUlIHBmupeNkh2loFyL5+LwsgnB+
         kXnJBNVeYtiZghOrij+VhEUYhJikCXFx6ExMLKtTSvPBZA7RaYYdmn3oHy6RZP/pqWn4
         HqhQ==
X-Gm-Message-State: AOJu0Yzx+ZAvHDDU2/qf9qaR0MveQbXXKelvl95nVVtg2U3+qHFd01p3
	z37AZoydW1ZYD6pYGsuiFAOjxrG3/gSEoFSocFEETxOxSKbH1YAFXC2pnFUAUzdTE5t/FDUjmEI
	RzAS/VJLaQYRPLTsAwYGyBG13QrTcmlpS
X-Google-Smtp-Source: AGHT+IF+szmBBVUba7RzxePCr44DpW8585Dvt4A2QMasC25IDJ4mu1ISE4MTPhAMxe7XbhSBN3tfd911H5N0OeZRn34=
X-Received: by 2002:a05:6870:808e:b0:23c:ad86:9933 with SMTP id
 586e51a60fabf-241726f5b28mr3961061fac.3.1715368201745; Fri, 10 May 2024
 12:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date: Sat, 11 May 2024 00:39:50 +0530
Message-ID: <CAPY=qRQR-wJ70gQfxxQ8m6r9XCKbQK5tWL9u=MNGbjb58=_huQ@mail.gmail.com>
Subject: spi: Inquiry Regarding Linux Kernel SPI Subsystem device drivers
To: linux-spi@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I hope this email finds you well. I am new to the Linux kernel SPI
subsystem, I am currently in the process of learning about its
functionalities and intricacies. I have a few doubts and questions
that I would like to clarify, and I am hoping you could provide some
assistance.

As I understand it, the Linux kernel SPI subsystem supports two main
types of SPI drivers: SPI controller drivers and SPI protocol drivers.
Much like the USB Skeleton driver (drivers/usb/usb-skeleton.c) serves
as an excellent reference example for new engineers developing USB
device drivers, I am wondering if there exists a similar skeleton
driver for both SPI controller and SPI protocol drivers within the
Linux kernel tree. Would it be possible for you to share any reference
code or examples for these drivers?

Additionally, I am curious about the interaction between user space
applications and SPI hardware devices on the target side through the
SPI protocol driver. Could you please clarify if user space
applications communicate with the hardware device on the target side
via the SPI protocol driver running on the host side?

Furthermore, I would like to inquire about the availability of an SPI
library for user space applications, similar to libusb for USB
communication. Does the SPI subsystem provide any such library, or do
user space applications communicate directly with the SPI protocol or
controller driver through system call?

Your insights into these matters would be immensely helpful for my
understanding of the Linux kernel SPI subsystem. Thank you very much
for your time and consideration.



Thank You!

