Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51A5310347
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhBEDJx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 22:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDJw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Feb 2021 22:09:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA89C0617A7;
        Thu,  4 Feb 2021 19:08:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g10so6020589wrx.1;
        Thu, 04 Feb 2021 19:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=pQw1eYLSdTjZvZOdl5Cr4//Nr8eiEDw9Q2r5puuK9/fs8HR+SpI2v81B2bI/LyejfM
         2JdjglncTUiZsvdsFPQ8KDuhkwkXoGq00ZFn7V20FbzvfRwQIrPSC1Ovu1CJn2HbT7s/
         z9v3HtLkw2wrotlB+2/YXOH1RMnLOTdyDlQVn3xhNvzEYqSrPkNAmV1jeAr2YOJtJMwF
         APP7Zvi0xmR5ZjxceEIEGO//K199AFUPYNo6lNU46fkbP9NVrobFA6ExkFnRlZNRK5Aq
         E3ofGoeLajcBOgBNw+evKlDAbj/h7EDjZOGullekQuqh3el3+Tv7zGmEBWsDIGXprSSy
         HSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=L3cdcsWRU7lYP0MvTfpH583+4oLUP2EBUZkLfXvJodl+fkxujZWC84vWwT1lNadKQN
         83+GzffFy7ffySR9zV6kb45iBA3haZowXZzOIrp4sYIRq13AeGQ7JI6KRXEBAc2lRYeB
         ZwUDg809/xjFTeBcgQRlo0BQQuNKoCG4hGc49xYZW7XcaLC88DrhJuSykw7RMFlyLNMa
         WuVsjCfcvuwo1B6jwZvD6HLVORMIC26Qizt/3J/OKU1sXUrVK5Rg8/Kn1K8Xko6eS1v2
         eFGGnJsZFV+PhRqrN6FAJQwDsxvWvfEfK8qlNWNRtMaYd0yI/vEEG6y+iVQfbh667zYS
         U2LQ==
X-Gm-Message-State: AOAM532C/e+7xc4MyAkv+anaVvwYzpzqSjRGDfmfHCia2XMIWpt+2dnp
        3owvIpQd2Dnrc6rV//0xHTX5R/6DLxiOJQ==
X-Google-Smtp-Source: ABdhPJypl7QfYrU8WT7a/sif0ddtG8fqAufMQ3cGVz0BrcCU9NLHB/GELTK9e37VHKCxGnApj+/dlw==
X-Received: by 2002:adf:f183:: with SMTP id h3mr2550860wro.30.1612494522287;
        Thu, 04 Feb 2021 19:08:42 -0800 (PST)
Received: from [192.168.1.6] ([154.124.28.35])
        by smtp.gmail.com with ESMTPSA id n9sm10836813wrq.41.2021.02.04.19.08.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2021 19:08:41 -0800 (PST)
Message-ID: <601cb6b9.1c69fb81.5ea54.2eaf@mx.google.com>
Sender: Skylar Anderson <barr.markimmbayie@gmail.com>
From:   calantha camara <sgt.andersonskylar0@gmail.com>
X-Google-Original-From: calantha camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi dear
To:     Recipients <calantha@vger.kernel.org>
Date:   Fri, 05 Feb 2021 03:08:34 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

do you speak Eglish
