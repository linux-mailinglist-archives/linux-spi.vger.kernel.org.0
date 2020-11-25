Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF162C48A8
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 20:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgKYTnm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 14:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgKYTnm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 14:43:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0FC0613D4
        for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2020 11:43:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so3096184wrt.2
        for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2020 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=MT4M9SX2NqdNuOObXhIV8Gtkw+yoDX+gRyJnh+feBwM=;
        b=bWG60mbKmLs6INacykACSh4POMB9gsnViE2aJBbgk1TnlVNTpOZKe77HRPUod+mLa2
         i3kK5EeyGQX7r4APQZg6h6ZMAHYo4X0hmX7aQ68VW/84/c2lhQcH1MdkL5mq7oBEySH4
         f5OJKYNI5k6tqLQTa0P7y9Esnw6TgK1sEdEbNXqmHxeEz14Pb9JbkaIz/IhhHxnLTC7S
         VQd/wlTl/6j0frj2BI4kTFHJA+hSmuJXGhPS3j2DFFlLBgTXzn22oEeTBdOa4wSd3tC8
         UVQWwBXW7BqQCs1EuxV/L3NZy/TI79nsc1QrUHI3KMXwdIQC6cxaOfFpsVg1Mr4ud8hs
         LDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=MT4M9SX2NqdNuOObXhIV8Gtkw+yoDX+gRyJnh+feBwM=;
        b=XNE4rnNfm/SeeapSXdXtRWqSBeTSSJyZvSUVqVReSgnuRUaPH8BlWwLVqfi4nSw/xE
         z1Ed/qQd5Kds8H13/PGhsOHkjDILe3BXnU6QBUeGkSmbyZ2evO73yGmTrkXnALIHM45u
         NYDc8q0caeUa9sLqTGlfGyfuUmlj4cUUqEZmxvrgek4FgU7uyiOA1zyLtfzi+Ubt4d0a
         49ag0metNA9UCQ1wZ95thRSZpYDdXJcRkh/Ud0kbHF8XFtjHen7vgYWlESbxjn3t24Xq
         xYfFRGhC2OUQKh0N1rf8JLo8Rw4aOp2k9YK+fhmF1YqUYdxa0ecQUqdbN5FeQYe11Lwt
         7utw==
X-Gm-Message-State: AOAM531uAJHtDm5w2/Kw2hu4lKXoI5WMMcoUTCbMOLeLI/aQBH/f215y
        Uf9RpqVL/yp3XHYWAvfkVw8=
X-Google-Smtp-Source: ABdhPJz5c/jemlDfZSkt8HoTqi/hw5OR0drI1s9UQ9JU/2zew46GkrZLGjldkHwL6pGjZQ7lDxjhVg==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr5833327wru.173.1606333419462;
        Wed, 25 Nov 2020 11:43:39 -0800 (PST)
Received: from [192.168.1.152] ([102.64.149.89])
        by smtp.gmail.com with ESMTPSA id u129sm5090970wme.9.2020.11.25.11.43.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2020 11:43:38 -0800 (PST)
Message-ID: <5fbeb3ea.1c69fb81.a9b8d.bd07@mx.google.com>
From:   "Dailborh R." <ritundailb333@gmail.com>
X-Google-Original-From: Dailborh R.
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Please reply to me
To:     Recipients <Dailborh@vger.kernel.org>
Date:   Wed, 25 Nov 2020 19:43:10 +0000
Reply-To: dailrrob.83@gmail.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I'm Dailborh R. from US. I picked interest in you and I would like to know
more about you and establish relationship with you. i will wait for
your response. thank you.

