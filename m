Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF17B315A99
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 01:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhBJAFd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Feb 2021 19:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhBIXQ7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Feb 2021 18:16:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED9C061788
        for <linux-spi@vger.kernel.org>; Tue,  9 Feb 2021 14:51:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p21so30860369lfu.11
        for <linux-spi@vger.kernel.org>; Tue, 09 Feb 2021 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+zlbiIHeEWSylL572dDyg11MHxrWh0joqSnh6rW+I20=;
        b=c5EtjxtHlb+ZogVKZI+7WVJefXaYQl2oRWqX8vO1j2DfCAxplNw3LWY4TL79C8OR1f
         +NGAR5OKB2Bg7NX3xG0j5XQZivsBx6JO7ZN9dppOfNWUe7J1gbM7/mvWIwFIwFzIg80J
         xQAJETctvD2gwwZQnJ9cBO5N423mT86mWkg3MBOoueswFPUjL3OEL7H0bFtwgktjyOTT
         ivyeAvZ9au2PFtkckCUSl/B72g/HZkZdkEKxQe6nobDnYh0HA3mdEwD6F1sCAA25iHX4
         s/d8gkYHJ28T1MEMixGgXRnNNKWB68Dy+Z7ezbH9l0uDk0dum1pMkmHnXFfKR34a+aET
         q/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=+zlbiIHeEWSylL572dDyg11MHxrWh0joqSnh6rW+I20=;
        b=UU6aokyiivM2iIcLxfUiIBMCT8+3bShbFwgXIsinONyhKvY4xJnZQjBSQZwic+sGMT
         tIvrJM0yKXlrXXxEQS7aCmGvVHugBY/LwWREgNScR36dR5x6BijgrlffSc9g+n7wIKGz
         Am2yyRoccco30mVscAyLsmpmOL0oUHm3kVzmSsUSGO2YWmZqe3H6xTP+W4PW5QzlZoAZ
         PZh1OyIgolLgLs5O+ugT6mYEvYWeswRy0W/oyIvxNgXZap5BxSg8m0EFuFDMS6PHkeNA
         K6OWyfqi/Hag7uZ2E6MZD9WpzKcjWS1PlU7OULZORow+mxsdJlehKZsIle4OsWtT+r01
         SskQ==
X-Gm-Message-State: AOAM531Sk1QPi4pnP/cnQCsOWcdFWXHvX6HKPSQF5nxrolU0vyfvE0Tf
        4hBQ7vQdcx1d3PvN9ImF0/xZd5cS1ohizFRWKeg=
X-Google-Smtp-Source: ABdhPJyhihwGAvML3ZTdQsKt8yTDggt7O28PsZ+VpbE3IK27YusWQSkTU2y2RqeqLhcYDhYnL9/I+IpEzTtbgBm4Gko=
X-Received: by 2002:a05:6512:5ca:: with SMTP id o10mr60559lfo.619.1612911104225;
 Tue, 09 Feb 2021 14:51:44 -0800 (PST)
MIME-Version: 1.0
Sender: robinrand8976@gmail.com
Received: by 2002:a2e:884e:0:0:0:0:0 with HTTP; Tue, 9 Feb 2021 14:51:43 -0800 (PST)
From:   Lisa Jaster <jaster189@gmail.com>
Date:   Tue, 9 Feb 2021 22:51:43 +0000
X-Google-Sender-Auth: qEYj2U1os2ZrOmGx7tBVU0Vcl-U
Message-ID: <CAJEAUxf7F2gYUCJmSp2AQW545sxm4nNzK-ovy1xdSJpthe=MOA@mail.gmail.com>
Subject: =?UTF-8?B?SnUgbHV0ZW1pIHDDq3JnamlnamVuaSBlbWFpbGluIHRpbSB0w6sgbcOrcGFyc2jDq20u?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Ju lutemi p=C3=ABrgjigjeni emailin tim t=C3=AB m=C3=ABparsh=C3=ABm.
