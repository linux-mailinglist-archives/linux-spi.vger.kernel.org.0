Return-Path: <linux-spi+bounces-7607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C2A8B03E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 08:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B45188DFD9
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C12206B3;
	Wed, 16 Apr 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmT5yhtH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6B219A81
	for <linux-spi@vger.kernel.org>; Wed, 16 Apr 2025 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784832; cv=none; b=YN4YOI0U6wKQYrwlynumacH1prCwZVtFi8r11so0VFlOWOL/CxfNcBkbawX7+TqUciP9mx1/8nxSxnVHx3Uv9VJY4GnkVAPy6Uq4yOSMb7IdpuatyUNREofocRQEtkBttdAtY2dwhJA3v4CbkMF/BDeDYI1oviowlPjggOfKSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784832; c=relaxed/simple;
	bh=EnZ2j660ClSt+1izrMNcjcqwRQyIWN1uDJBL2Kp6hvU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j5CxCUknOrTysPNWnaUe/HjWu5rD+aZ1lIvFE/DgCMyJQYBnhjfPX5CmodjZQJfLveoqzEHBjjN7WHa5L98fcl+YSAMBxSjPY1UOTP8pY93fCgxs+2j6PKWc/YYIxWsbSDPZXKhARpe9MFyigZ+xSdgQSenGEHBz0nUPZTKkEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmT5yhtH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c47631b4cso3679622a34.1
        for <linux-spi@vger.kernel.org>; Tue, 15 Apr 2025 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744784829; x=1745389629; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EnZ2j660ClSt+1izrMNcjcqwRQyIWN1uDJBL2Kp6hvU=;
        b=YmT5yhtHhkDPDeQZNj5cGumuvwE3UgC6hOvSCHPJe8FJz1Iec9PuQ6LEn7hsZs/5i1
         +R+5/sSK3vOrVrL86lEy3spZnfuPWb5OPY0CniKGd4ZFNtp+XkfY2eDSWKalAxvncQnJ
         Ie6qUFZEXFxIYMZQX3WASndn5Ep7m+qzRdlZIrFW4UWeDD7YdjsgPn+qVNRiVPyfz4GC
         ex02uAEINWkAbLSZLqnBHRZVckaz1mwCLdAFhjM+foXrveyChaaNAI9PSfldI1UvQFBR
         zL/i5YYkACXk3jpNnZcLR56lEvtPclAk51DFwX2jvLdHjuC9vgADdknK+Kp1+soNt9FU
         6qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784829; x=1745389629;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EnZ2j660ClSt+1izrMNcjcqwRQyIWN1uDJBL2Kp6hvU=;
        b=ngQnpgsXKIWu7xB2goeNb9/PFWOPGmiYQw0UXiQq+aQr6fJZdw1zPLKIYn+GqjT592
         A+Pry7LlYmfa3PWETuzSWmgoBzke1Xgp4/WHz00mPUnT7s+diWXC4xKJDVLMv8bWdNAV
         EBeOVpX3nX4Ln79LJpVMt2mxL+CoQv1yZxz+OcvmfUUQYCxrca3lES15GTbQ7/XrLVQS
         PwKQ2plr4rU8+ekwbXoQLDd09bWN4a6yMIceKQaJPOM6P8dt0ihtth0sypQ388k6580L
         SWHt4D2rFr8FlSOdArJ9SATfxycYrkQBf7dwvLAWrs/15cr0L1OAzRR5+iThzkEcgWAy
         sqVg==
X-Gm-Message-State: AOJu0Ywj5phJWybcL80MBXy33r81ERpKzg9PwGq+jvWr8uyHEmIs88SM
	vYozKPDucS742GzIzY5886Ij9GzCz2ffqOwLYQN1o63DfHQTYQSSeTcQ2+xkRG6gMd8mVQCkpXI
	tqjFTuzwA9EOsZUVJ9G2jikH5IRn9qsGd
X-Gm-Gg: ASbGncs9ljD52TSz0/evCQHF8osFotYPa5te83E3q0xvoTncp3EMuocOrsISm4NYfJb
	KO3jVcV+U6r8FDS4/t+2Ym8TAtaCBIxVgVG5u1NVHngBps/DFr4HpfoJvPV8CfqF8HlvjMzIYOz
	wc017EFnvZGdXWGAO7CzAU5jc=
X-Google-Smtp-Source: AGHT+IHbf1WtJVatuIWu4ezJV58r7Ux41uEDo1wGCq9EdCQWCVwhe68h7ZExttpM57kVqBBhWhqAGl4RdFxbV6Dltx0=
X-Received: by 2002:a05:6830:b94:b0:72b:9506:8db0 with SMTP id
 46e09a7af769-72ec6bcf36dmr225217a34.12.1744784829223; Tue, 15 Apr 2025
 23:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date: Wed, 16 Apr 2025 11:56:57 +0530
X-Gm-Features: ATxdqUFTTAX1aFPsf89biXl3VreRbwPcW5OxW622xnskVDHfQYnUY7kpz_hLhGU
Message-ID: <CAPY=qRSFSRErqs2pPJpdEH1hADhkuz7Nwzz5utG6bvzKOOkpwg@mail.gmail.com>
Subject: spi : Data Throughput via spi-loopback-test.ko
To: linux-spi@vger.kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linux-SPI Community,

We have a SPI controller driver on our Linux test platform. We need to
implement the BT protocol driver on top of it. Prior to that, is it
possible to get the data throughput via spi-loopback-test.ko? If so,
how can we achieve it? Should we use spidev_test for this purpose? Any
inputs on this would be greatly appreciated.

Thank you for your assistance.

